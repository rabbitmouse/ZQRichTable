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

@property (nonatomic, strong) ZQMediaItem *mediaItem;
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, copy)   NSString  *imageDesc;
@property (nonatomic, assign) CGFloat   height;
@property (nonatomic, assign) NSInteger row;

@property (nonatomic, assign) BOOL isMerged;
@property (nonatomic, assign) BOOL isEditing;

@end
