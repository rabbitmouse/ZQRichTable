//
//  ZQRichTableView.m
//  ZQRichTableExample
//
//  Created by zzq on 2018/7/23.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQRichTableView.h"
#import "XRDragTableView.h"

#import "ZQBaseRichTableViewCell.h"
#import "ZQImageViewTableViewCell.h"
#import "ZQTextTableViewCell.h"

#import "ZQMacro.h"

@interface ZQRichTableView ()<UITableViewDelegate ,UITableViewDataSource, TableViewCallBackDelegate>
@property (nonatomic, strong) XRDragTableView *tableView;

@end

@implementation ZQRichTableView

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUI];
    
    [self setupTableView];
    
    [self loadContentList];
}

- (void)addUI {
    XRDragTableView *tableView = [[XRDragTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - View Helpers

- (void)initSubviews {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    UIBarButtonItem *publish = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_publish"] style:UIBarButtonItemStylePlain target:self action:@selector(publish:)];
    self.navigationItem.rightBarButtonItem = publish;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZQTextTableViewCell class]) bundle:nil] forCellReuseIdentifier:[ZQBaseRichTableViewCell cellIdForType:ZQMediaItemType_Paragraph]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZQImageViewTableViewCell class]) bundle:nil] forCellReuseIdentifier:[ZQBaseRichTableViewCell cellIdForType:ZQMediaItemType_Image]];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataArray = self.contentList;
    self.tableView.scrollSpeed = 10;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView setTableHeaderView:[[ZQTitleHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)]];
    [self.tableView setTableFooterView:[UIView new]];
}

- (void)loadContentList {
    self.contentList = [NSMutableArray new];
    ZQMediaItem *item = [ZQMediaItem new];
    item.type = ZQMediaItemType_Paragraph;
    item.title = @"";
    ZQRichDataModel *model = [ZQRichDataModel new];
    model.mediaItem = item;
    [self.contentList addObject:model];
    [self updateListPositionSort];
}


#pragma mark - Action

- (void)back {
//    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publish:(UIBarButtonItem *)sender {
    
}

#pragma mark - private

- (void)updateListPositionSort {
    [self.contentList enumerateObjectsUsingBlock:^(ZQRichDataModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.row = idx;
    }];
}

static const NSUInteger kMBPostPhotosLimit = 9;
- (BOOL)isPhotosExceedTheLimit {
    NSUInteger limit = kMBPostPhotosLimit;
    return [self photosNumber] >= limit;
}

- (NSUInteger)photosNumber {
    NSUInteger iNum = 0;
    for (ZQRichDataModel *model in self.contentList) {
        if (!model.image) {
            continue;
        }
        iNum++;
    }
    return iNum;
}

- (NSArray<UIImage *> *)selectedImages {
    NSMutableArray *images = [NSMutableArray array];
    for (ZQRichDataModel *model in self.contentList) {
        if (model.image) {
            [images addObject:model.image];
        }
    }
    return [images copy];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZQRichDataModel *model = self.contentList[indexPath.row];
    ZQBaseRichTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: [ZQBaseRichTableViewCell cellIdForType:model.mediaItem.type]];
    cell.delegate = self;
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZQRichDataModel *model = self.contentList[indexPath.row];
    return MAX(30.0, model.height);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - TableViewCallBackDelegate

- (void)tableViewCellCallBack:(CallBackType)type dataModel:(ZQRichDataModel *)dataModel value:(id)obj{
    switch (type) {
        case CallBackTypeAddImage: {
            [self.view endEditing:YES];
            
            NSRange range = [obj rangeValue];
            NSArray *images = [self.delegate needSelectImagesForTableView:self.tableView];
            
            [self addImageWithdataModel:dataModel range:range images:images];
        }
            break;
        case CallBackTypeDelete: {
            //移除图片
            ZQRichDataModel *beforeModel = self.contentList[dataModel.row - 1];
            ZQRichDataModel *nextModel = self.contentList[dataModel.row + 1];
            if((nextModel.mediaItem.title.length > 0)) {
                beforeModel.mediaItem.title = [NSString stringWithFormat:@"%@\n%@",beforeModel.mediaItem.title,nextModel.mediaItem.title];
            }
            [self.contentList removeObject:nextModel];
            [self.contentList removeObject:dataModel];
            [self updateListPositionSort];
            [self.tableView reloadData];
        }
            break;
        case CallBackTypePreviewImage: {
            NSMutableArray *images = [NSMutableArray array];
            for (ZQRichDataModel *model in self.contentList) {
                if(model.mediaItem.type == ZQMediaItemType_Image) {
                    [images addObject:model.image];
                }
            }
            NSInteger curIndex = [images indexOfObject:dataModel.image];
            if (self.delegate && [self.delegate respondsToSelector:@selector(richTableView:didWatchImages:currentIndex:)]) {
                [self.delegate richTableView:self.tableView didWatchImages:images currentIndex:curIndex];
            }
        }
            break;
        case CallBackTypeMove: {
            //长按移动
            [self.tableView moveRow:obj];
        }
        default:
            break;
    }
}



- (void)addImageWithdataModel:(ZQRichDataModel *)dataModel range:(NSRange)range images:(NSArray *)images {
    
    [images enumerateObjectsUsingBlock:^(UIImage *img, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ZQMediaItem *item1 = [ZQMediaItem new];
        item1.type = ZQMediaItemType_Image;
        ZQRichDataModel *model1 = [ZQRichDataModel new];
        model1.image = img;
        model1.mediaItem = item1;
        
        ZQMediaItem *item2 = [ZQMediaItem new];
        item2.type = ZQMediaItemType_Image;
        item2.title = idx == images.count - 1 ? [dataModel.mediaItem.title substringFromIndex:range.location] : @"";
        ZQRichDataModel *model2 = [ZQRichDataModel new];
        model2.mediaItem = item2;
        
        [self.contentList insertObject:model1 atIndex:dataModel.row + idx*2 + 1];
        [self.contentList insertObject:model2 atIndex:dataModel.row + idx*2 + 2];
        
    }];
    dataModel.mediaItem.title = [dataModel.mediaItem.title substringToIndex:range.location];
    [self updateListPositionSort];
    [self.tableView reloadData];
}

#pragma mark - Getters & Setters

- (NSMutableArray *)invitations {
    if(!_contentList) {
        _contentList = [NSMutableArray array];
    }
    return _contentList;
}
     
@end

#pragma mark - MBCreateForumHeader
@interface ZQTitleHeader()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *field;

@end

@implementation ZQTitleHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 15*2, 30)];
        field.placeholder = @"标题";
        field.font = [UIFont systemFontOfSize:16.f];
        field.delegate = self;
        [self addSubview:field];
        self.field = field;
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, frame.size.height, frame.size.width, 1);
        layer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [self.layer addSublayer:layer];
    }
    return self;
}

- (NSString *)getTitleText {
    return self.field.text;
}

- (void)setTitleText:(NSString *)title {
    self.field.text = title;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return range.location < 40;
}

@end

