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
- (NSArray<UIImage *> *)needSelectImagesForTableView:(UITableView *)tableView;

@optional
// 点击查看某张图片
- (void)richTableView:(UITableView *)tableview didWatchImages:(NSArray<UIImage *> *)images currentIndex:(NSInteger)index;

// 获取tableview上所有图片
- (NSArray<UIImage *> *)selectedImages;

@end

@interface ZQRichTableView : UIViewController

@property (nonatomic, strong) NSMutableArray<ZQRichDataModel *> *contentList;

@property (nonatomic, weak) id<ZQRichTableViewDelegate> delegate;

@end

@interface ZQTitleHeader : UIView

- (void)setTitleText:(NSString *)title;
- (NSString *)getTitleText;

@end
