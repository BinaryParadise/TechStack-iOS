//
//  NLUIDefine.h
//  Neverland
//
//  Created by RakeYang on 2019/11/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

typedef NS_ENUM(NSUInteger, FDRefreshState) {
    FDRefreshStateFirst     = 0,        //首次
    FDRefreshStatePullDown  = 1 << 0,   //下拉
    FDRefreshStatePullUp    = 1 << 1    //上拉
};

typedef NS_OPTIONS(NSUInteger, FDRefreshFooterViewState) {
    FDRefreshFooterViewStateIdle = 0,
    FDRefreshFooterViewStateRefreshing = 1 << 0
};
