//
//  ZQBaseRichTableViewCell.h
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQRichDataModel.h"

typedef NS_ENUM(NSUInteger, CellBlockType) {
    kCellBlockTypeParagraph = 1,
    kCellBlockTypeImage,
};

typedef NS_ENUM(NSUInteger, CallBackType) {
    CallBackTypeAddImage,
    CallBackTypeDelete,
    CallBackTypePreviewImage,
    CallBackTypeMove,
};

@protocol TableViewCallBackDelegate <NSObject>

- (void)tableViewCellCallBack:(CallBackType)type dataModel:(ZQRichDataModel *)model value:(id)obj;

@end

@interface ZQBaseRichTableViewCell : UITableViewCell

+ (NSString *)cellIdForType:(ZQMediaItemType)type;
- (UITableView *)tableView;

@property (nonatomic, strong) ZQRichDataModel *model;

@property (nonatomic, weak) id<TableViewCallBackDelegate> delegate;

@end
