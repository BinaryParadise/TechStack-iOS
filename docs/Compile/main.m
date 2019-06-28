#import <Foundation/Foundation.h>

#define DefaultNum 8

int main() {
  @autoreleasepool {
    int num = DefaultNum;
    int six = 8;
    NSString* site = [[NSString alloc] initWithUTF8String:"BinaryParadise"];
    int rank = num + six;
    NSLog(@"%@ rank %d", site, rank);
  }
  return 0;
}
