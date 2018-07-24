//
//  DemoViewController.m
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "DemoViewController.h"
#import ""

@interface DemoViewController ()<ZQRichTableViewDelegate>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (NSArray<UIImage *> *)needSelectImagesForTableView:(UITableView *)tableView {
    TZImagePickerController* imagePickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:maxImageCount delegate:nil];
    //默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
    //    imagePickerController.photoWidth = photoWidth;
    imagePickerController.selectedAssets = selectedAssets;
    imagePickerController.allowPickingVideo = NO;
    imagePickerController.allowPickingOriginalPhoto = NO;
    
    [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        completion(photos, assets);
    }];
    
    
    [[NavigationHelper visibleViewController]presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}


- (void)richTableView:(UITableView *)tableview didWatchImages:(NSArray<UIImage *> *)images currentIndex:(NSInteger)index {
    
}

/*
 TZImagePickerController* imagePickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:maxImageCount delegate:nil];
 //默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
 //    imagePickerController.photoWidth = photoWidth;
 imagePickerController.selectedAssets = selectedAssets;
 imagePickerController.allowPickingVideo = NO;
 imagePickerController.allowPickingOriginalPhoto = NO;
 
 [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
 completion(photos, assets);
 }];
 
 
 [[NavigationHelper visibleViewController]presentViewController:imagePickerController animated:YES completion:^{
 
 }];
*/

@end
