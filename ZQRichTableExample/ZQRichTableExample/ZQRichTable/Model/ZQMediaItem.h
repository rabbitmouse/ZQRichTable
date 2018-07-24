//
//  ZQMediaItem.h
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZQMediaItemType) {
    ZQMediaItemType_Paragraph = 1 << 1,        // 文档内容
    ZQMediaItemType_Image,            // 图片
    ZQMediaItemType_Title,
};


@interface ZQMediaItem : NSObject

@property (nonatomic, strong) NSString *title;


@property (assign, nonatomic) ZQMediaItemType type;

@end
