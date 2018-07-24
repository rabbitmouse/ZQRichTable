//
//  MBKeyboardToolView.h
//  MBKeyboardToolView
//
//  Created by bltech on 17/3/21.
//  Copyright © 2017年 Bltech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MBKeyboardToolViewButtonClickBlock)(UIButton *button, NSUInteger index);

@interface MBKeyboardToolView : UIView

+ (instancetype)toolView;

@property (nonatomic, strong) NSArray<NSString *> *lBtnImgNames;
@property (nonatomic, strong) NSArray<NSString *> *rBtnImgNames;

@property (nonatomic, copy) MBKeyboardToolViewButtonClickBlock lBtnClickBlock;
@property (nonatomic, copy) MBKeyboardToolViewButtonClickBlock rBtnClickBlock;

@end
