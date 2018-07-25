//
//  ZQRichTableView.h
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ZQRichDataModel.h"

@protocol ZQRichTableViewDelegate<NSObject>
@required
- (void )needSelectImagesForTableView:(UITableView *)tableView selectedImages:(void(^)(NSArray<UIImage *> *images))block;
- (void )needTakePhotoForTableView:(UITableView *)tableView photo:(void(^)(UIImage *images))block;

@optional
// 点击查看某张图片
- (void)richTableView:(UITableView *)tableview didWatchImages:(NSArray<UIImage *> *)images currentIndex:(NSInteger)index;

// 获取tableview上所有图片
- (NSArray<UIImage *> *)selectedImages;

@end

@interface ZQRichTableView : UIViewController

@property (nonatomic, strong) NSMutableArray<ZQRichDataModel *> *contentList;

@property (nonatomic, weak) id<ZQRichTableViewDelegate> delegate;

@property (nonatomic, copy, readonly) NSString *titleText;


@end

@interface ZQTitleHeader : UIView

- (void)setTitleText:(NSString *)title;
- (NSString *)getTitleText;

@end
