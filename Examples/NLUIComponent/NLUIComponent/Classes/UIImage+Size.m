//
//  UIImage+Size.m
//  NLUIComponent
//
//  Created by Rake Yang on 2019/12/14.
//

#import "UIImage+Size.h"

typedef NS_OPTIONS(NSUInteger, ImageDataType) {
    ImageDataTypeNone    = 0,
    ImageDataTypeJpeg    = 0xFF,
    ImageDataTypePng     = 0x89,
    ImageDataTypeGif     = 0x47,
    ImageDataTypeTiff    = 0x4D,
    ImageDataTypeWebp    = 0x52
};

NSString *const kPngRangeValue = @"bytes=16-23";
NSString *const kJpgRangeValue = @"bytes=0-209";
NSString *const kGifRangeValue = @"bytes=6-9";

extern CGSize adjustSizeWithLimit(CGSize origin, CGSize limit) {
    if (CGSizeEqualToSize(limit, CGSizeZero)) {
        return origin;
    } else {
        if (origin.width / origin.height <= limit.width / limit.height) {
            //限制高度
            CGFloat imgH = MIN(origin.height, limit.height);
            CGFloat imgW = origin.width * imgH / origin.height;
            return CGSizeMake(imgW, imgH);
        } else {
            //限制宽度
            CGFloat imgW = MIN(origin.width, limit.width);
            CGFloat imgH = origin.height * imgW / origin.width;
            return CGSizeMake(imgW, imgH);
        }
    }
}

@implementation UIImage (Size)

- (CGSize)adjustSizeWithLimit:(CGSize)limit {
    return adjustSizeWithLimit(self.size, limit);
}

+ (void)remoteSize:(NSString *)imgURL completion:(void (^)(NSURL * _Nonnull, CGSize))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imgURL]];
    [request setValue:kJpgRangeValue forHTTPHeaderField:@"Range"];
    [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        ImageDataType type = [self typeForImageData:data];
        CGSize size = CGSizeZero;
        switch (type) {
            case ImageDataTypeJpeg:
                size = [self JPGImageSizeWithRangeHeader:data];
                break;
            case ImageDataTypePng:
                size = [self PNGImageSizeWithRangeHeader:data];
            case ImageDataTypeGif: [self GIFImageSizeWithRangeHeader:data];
            case ImageDataTypeTiff: [self BMPImageSizeWithRangeHeader:data];
            default:
                break;
        }
        if (completion) {
            completion(imgURL, size);
        }
    }];
}

+ (CGSize)PNGImageSizeWithRangeHeader:(NSData *)data{
    const unsigned char *cString = [data bytes];
    const NSInteger length = [data length];
    char type[5];
    int offset = 8;
    
    uint32_t chunkSize = 0;
    int chunkSizeSize = sizeof(chunkSize);
    if( offset+chunkSizeSize > length )
        return CGSizeZero;
    
    memcpy(&chunkSize, cString+offset, chunkSizeSize);
    chunkSize = OSSwapInt32(chunkSize);
    offset += chunkSizeSize;
    
    if( offset + chunkSize > length )
        return CGSizeZero;
    
    memcpy(&type, cString+offset, 4); type[4]='\0';
    offset += 4;
    
    if(strcmp(type, "IHDR") == 0 ) {   //Should always be first
        uint32_t width = 0, height = 0;
        memcpy(&width, cString+offset, 4);
        offset += 4;
        width = OSSwapInt32(width);
        memcpy(&height, cString+offset, 4);
        offset += 4;
        height = OSSwapInt32(height);
        return CGSizeMake(width, height);
    }
    return CGSizeZero;
}
+(CGSize)JPGImageSizeWithRangeHeader:(NSData *)data{
    const unsigned char *cString = [data bytes];
    const NSInteger length = [data length];
    int offset = 4;
    uint32_t block_length = cString[offset]*256 + cString[offset+1];
    
    while (offset<length) {
        offset += block_length;
        
        if( offset >= length )
            break;
        if( cString[offset] != 0xFF )
            break;
        if( cString[offset+1] == 0xC0 ||
           cString[offset+1] == 0xC1 ||
           cString[offset+1] == 0xC2 ||
           cString[offset+1] == 0xC3 ||
           cString[offset+1] == 0xC5 ||
           cString[offset+1] == 0xC6 ||
           cString[offset+1] == 0xC7 ||
           cString[offset+1] == 0xC9 ||
           cString[offset+1] == 0xCA ||
           cString[offset+1] == 0xCB ||
           cString[offset+1] == 0xCD ||
           cString[offset+1] == 0xCE ||
           cString[offset+1] == 0xCF ) {
            
            uint32_t width = 0, height = 0;
            
            height = cString[offset+5]*256 + cString[offset+6];
            width = cString[offset+7]*256 + cString[offset+8];
            
            return CGSizeMake(width, height);
            
        }
        else {
            offset += 2;
            block_length = cString[offset]*256 + cString[offset+1];
        }
        
    }
    return CGSizeZero;
}
+(CGSize)GIFImageSizeWithRangeHeader:(NSData *)data{
    const unsigned char *cString = [data bytes];
    
    int offset = 6;
    uint32_t width = 0, height = 0;
    memcpy(&width, cString+offset, 2);
    offset += 2;
    
    memcpy(&height, cString+offset, 2);
    offset += 2;
    return CGSizeMake(width, height);
}
+(CGSize)BMPImageSizeWithRangeHeader:(NSData *)data{
    const unsigned char *cString = [data bytes];
    
    int offset = 18;
    int width = 0, height = 0;
    memcpy(&width, cString+offset, 4);
    offset += 4;
    
    memcpy(&height, cString+offset, 4);
    offset += 4;
    return CGSizeMake(width, height);
}

+ (ImageDataType)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0x52: {
            //R as RIFF for WEBP
            if (data.length < 12) {
                return ImageDataTypeNone;
            }
            NSString *identifierTypeStr = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([identifierTypeStr hasPrefix:@"RIFF"] && [identifierTypeStr hasSuffix:@"WEBP"]) {
                return ImageDataTypeWebp;
            }
            return ImageDataTypeNone;
        }
        default: return c;
    }
}

@end
