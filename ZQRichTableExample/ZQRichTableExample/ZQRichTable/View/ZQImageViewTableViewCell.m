//
//  ZQImageViewTableViewCell.m
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQImageViewTableViewCell.h"
#import "ZQRichDataModel.h"
#import "ZQMacro.h"

static CGFloat margin = 5;

@interface ZQImageViewTableViewCell()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *textView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textConstraint;

@end

@implementation ZQImageViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textConstraint.constant = 0;
    self.textView.hidden = YES;
    
//    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.bounds = CGRectMake(0, 0, kScreenWidth - 30, self.topConstraint.constant);
    maskLayer.position = CGPointMake(CGRectGetWidth(maskLayer.bounds)/2, self.topConstraint.constant/2);
    maskLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
    [self.topView.layer addSublayer:maskLayer];
}

- (void)setModel:(ZQRichDataModel *)model {
    [super setModel:model];

    self.image.image = model.image ?: [UIImage imageNamed:@"timg"];
    
//    CGFloat height = [self.textView sizeThatFits:CGSizeMake(self.bounds.size.width - 15 * 3, MAXFLOAT)].height;
//    self.textConstraint.constant = height > 40 ? height:40;
    model.height = self.topConstraint.constant + margin*2 ;
}

#pragma mark - Text View Delegate

- (void)textViewDidChange:(UITextView *)textView {
    if(textView.isFirstResponder) {
        self.model.imageDesc = textView.text;
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if(textView.isFirstResponder) {
        CGFloat height = [self.textView sizeThatFits:CGSizeMake(self.bounds.size.width - 15 * 3, MAXFLOAT)].height;
        self.textConstraint.constant = height > 40 ? height:40;
        self.model.height = self.topConstraint.constant + margin*2 + self.textConstraint.constant;
        
        UITableView *tableView = [self tableView];
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if(textView.isFirstResponder) {
        if ([text isEqualToString:@""] && range.length > 0) {
            //删除字符肯定是安全的
            return YES;
        }
        else {
            if (textView.text.length - range.length + text.length > 30) {
                return NO;
            }
            else {
                return YES;
            }
        }
    }
    return YES;
}

#pragma mark - action
- (IBAction)editButtonClicked:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableViewCellCallBack:dataModel:value:)]) {
        [self.delegate tableViewCellCallBack:CallBackTypeDelete dataModel:self.model value:nil];
    }
}

- (IBAction)previewButtonClicked:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableViewCellCallBack:dataModel:value:)]) {
        [self.delegate tableViewCellCallBack:CallBackTypePreviewImage dataModel:self.model value:nil];
    }
}

- (void)longPress:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableViewCellCallBack:dataModel:value:)]) {
        [self.delegate tableViewCellCallBack:CallBackTypeMove dataModel:self.model value:sender];
    }
}

@end
