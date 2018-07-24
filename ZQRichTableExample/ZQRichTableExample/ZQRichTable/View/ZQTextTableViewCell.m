//
//  ZQTextTableViewCell.m
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQTextTableViewCell.h"
#import "MBKeyboardToolView.h"
#import "ZQMacro.h"

@interface ZQTextTableViewCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, weak) MBKeyboardToolView *toolBar;
@end

@implementation ZQTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.textView.scrollEnabled = NO;
    self.textView.delegate = self;
    
     [self addToolBar];
}


- (void)setModel:(ZQRichDataModel *)model {
    [super setModel:model];
    
    if(model.isEditing) {
    }
    self.textView.text = model.mediaItem.title;
    if([self.textView.text isEqualToString:@""]) {
        model.height = 50;
    }
    else {
        model.height = [self.textView sizeThatFits:CGSizeMake(kScreenWidth - 15 * 3, MAXFLOAT)].height;
    }
}

- (void)addToolBar {
    MBKeyboardToolView *toolBar = [MBKeyboardToolView toolView];
    toolBar.lBtnImgNames = @[@"ic_photo", @"ic_picture"];
    toolBar.rBtnImgNames = @[@"ic_keyboard"];
    
    __weak ZQTextTableViewCell *weakCell = self;
    toolBar.lBtnClickBlock = ^(UIButton *button, NSUInteger index) {
        switch (index) {
            case 0:
            {
                if(weakCell.delegate && [weakCell.delegate respondsToSelector:@selector(tableViewCellCallBack:dataModel:value:)]) {
                    [weakCell.delegate tableViewCellCallBack:-1
                                                   dataModel:self.model
                                                       value:[NSNumber valueWithRange:self.textView.selectedRange]];
                }
            }
                break;
            case 1:
            {
                if(weakCell.delegate && [weakCell.delegate respondsToSelector:@selector(tableViewCellCallBack:dataModel:value:)]) {
                    [weakCell.delegate tableViewCellCallBack:0
                                                   dataModel:self.model
                                                       value:[NSNumber valueWithRange:self.textView.selectedRange]];
                }
            }
                break;
            default:
                break;
        }
    };
    
    toolBar.rBtnClickBlock = ^(UIButton *button, NSUInteger index) {
        [weakCell.textView resignFirstResponder];
    };
    
    self.toolBar = toolBar;
    self.textView.inputAccessoryView = toolBar;
}

#pragma mark - Text View Delegate

- (void)textViewDidChange:(UITextView *)textView {
    if(textView.isFirstResponder) {
        self.model.mediaItem.title = textView.text;
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if(textView.isFirstResponder) {
        self.model.height = [self.textView sizeThatFits:CGSizeMake(kScreenWidth - 15 * 3, MAXFLOAT)].height;
        
        UITableView *tableView = [self tableView];
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

@end
