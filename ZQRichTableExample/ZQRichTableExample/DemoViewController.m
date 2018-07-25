//
//  DemoViewController.m
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "DemoViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface DemoViewController ()<ZQRichTableViewDelegate>

@property (nonatomic, strong) NSMutableArray *selectAssets;


@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    self.selectAssets = [NSMutableArray new];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backtosuper)];
}

- (void)backtosuper {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 使用了xib，子类需要实现这个方法
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:NSStringFromClass([ZQRichTableView class]) bundle:nibBundleOrNil];
    return self;
}


#pragma mark - ZQRichTableViewDelegate
- (void)needSelectImagesForTableView:(UITableView *)tableView selectedImages:(void (^)(NSArray<UIImage *> *))block {
    //选择图片
    [self pickerImage:^(NSArray *images) {
        block(images);
    }];
}

- (void)needTakePhotoForTableView:(UITableView *)tableView photo:(void (^)(UIImage *))block {
    
}

- (void)richTableView:(UITableView *)tableview didWatchImages:(NSArray<UIImage *> *)images currentIndex:(NSInteger)index {
    //调用查看图片控件
}


#pragma mark - privare
- (void)pickerImage:(void(^)(NSArray *images))block {
    
    TZImagePickerController* imagePickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:nil];
    //默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
    //    imagePickerController.photoWidth = photoWidth;
    imagePickerController.selectedAssets = nil;
    imagePickerController.allowPickingVideo = NO;
    imagePickerController.allowPickingOriginalPhoto = NO;
    
    [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.selectAssets = [NSMutableArray arrayWithArray:assets];
        block(photos);
    }];
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}




@end
