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

@interface ZQTextTableViewCell()<UITextViewDelegate> {
    CGFloat _preTextHeight;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, weak) MBKeyboardToolView *toolBar;
@end

@implementation ZQTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
        model.height = [self.textView sizeThatFits:CGSizeMake(kScreenWidth - 15 * 2, MAXFLOAT)].height;
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
                    [weakCell.delegate tableViewCellCallBack:CallBackTypeTakePhoto
                                                   dataModel:self.model
                                                       value:[NSNumber valueWithRange:self.textView.selectedRange]];
                }
            }
                break;
            case 1:
            {
                if(weakCell.delegate && [weakCell.delegate respondsToSelector:@selector(tableViewCellCallBack:dataModel:value:)]) {
                    [weakCell.delegate tableViewCellCallBack:CallBackTypeAddImage
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    CGFloat curHeight = [textView sizeThatFits:CGSizeMake(kScreenWidth - 15 * 2, MAXFLOAT)].height;
    if ([text isEqualToString:@"\n"]) {
        curHeight += 20.f;
    }
    
    if (curHeight != _preTextHeight && curHeight > 40) {
        _preTextHeight = curHeight;
        self.model.height = curHeight;
        UITableView *tableView = [self tableView];
        [tableView beginUpdates];
        [tableView endUpdates];
    }
    
    return YES;
}

@end
