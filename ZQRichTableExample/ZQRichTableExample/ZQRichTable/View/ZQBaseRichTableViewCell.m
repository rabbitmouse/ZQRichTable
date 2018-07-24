//
//  ZQBaseRichTableViewCell.m
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQBaseRichTableViewCell.h"
#import "ZQTextTableViewCell.h"
#import "ZQImageViewTableViewCell.h"

@implementation ZQBaseRichTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


+ (NSString *)cellIdForType:(ZQMediaItemType)type {
    switch (type) {
        case ZQMediaItemType_Paragraph:
            return @"ZQTextTableViewCell";
            break;
        case ZQMediaItemType_Image:
            return @"ZQImageViewTableViewCell";
            break;
            
        default:
            return @"ZQMediaItemType_Title";
            break;
    }
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}


- (void)setModel:(ZQRichDataModel *)model {
    _model = model;
}

@end
