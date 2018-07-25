//
//  ZQRichDataModel.h
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZQMediaItem.h"

@interface ZQRichDataModel : NSObject
//媒体对象
@property (nonatomic, strong) ZQMediaItem *mediaItem;
//数据
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, copy)   NSString  *imageDesc;

//布局
@property (nonatomic, assign) CGFloat   height;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) BOOL isMerged;
@property (nonatomic, assign) BOOL isEditing;

@end
