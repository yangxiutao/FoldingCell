//
//  TestViewController.m
//  FoldingTablView
//
//  Created by YXT on 2016/11/28.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "TestViewController.h"
#import "Network.h"

@interface TestViewController ()<FoldingTableViewDelegate, FoldingTableViewDataSource>

@property (nonatomic, weak) FoldingTableView *foldingTableView;

@property (nonatomic, strong) NSArray *showArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建tableView
    [self setupFoldingTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [Network pictypeSuccess:^(NSArray *listArray) {
        
        self.showArray = [NSArray arrayWithArray:listArray];
        
        //不加上这个，加载时间会很长
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.foldingTableView reloadData];
        });
       
    } failure:^(id error) {
        NSLog(@"%@",error);
    }];
}

// 创建tableView
- (void)setupFoldingTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    FoldingTableView *foldingTableView = [[FoldingTableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    foldingTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _foldingTableView = foldingTableView;
    
    [self.view addSubview:foldingTableView];
    foldingTableView.foldingTableViewDelegate = self;
    foldingTableView.foldingTableViewDataSource = self;
}


#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）

// 返回箭头的位置
- (FoldingSectionHeaderArrowPosition)perferedArrowPositionForFoldingTableView:(FoldingTableView *)foldingTableView{
    // 没有赋值，默认箭头在左
    return self.arrowPosintion?FoldingSectionHeaderArrowPositionLeft:FoldingSectionHeaderArrowPositionRight;
//    return self.arrowPosintion;
}

//返回组数
- (NSInteger)numberOfSectionForFoldingTableView:(FoldingTableView *)foldingTableView{
    return self.showArray.count;
}

//返回每组 cell 数目
- (NSInteger)foldingTableView:(FoldingTableView *)foldingTableView numberOfRowsInSection:(NSInteger)section{
    
    return [[[self.showArray objectAtIndex:section] valueForKey:@"list"] count];
}

//Header Height
- (CGFloat)foldingTableView:(FoldingTableView *)foldingTableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//Row Height
- (CGFloat)foldingTableView:(FoldingTableView *)foldingTableView heightForRowAtIndexPath:(NSIndexPath *)indexpath{
    
    return 50;
}

//Header Title
- (NSString *)foldingTableView:(FoldingTableView *)foldingTableView titleForHeaderInSection:(NSInteger)section{
    
    NSDictionary *sectionDic = [self.showArray objectAtIndex:section];
    return [NSString stringWithFormat:@"%@",[sectionDic valueForKey:@"name"]];
}

//Header Decription Text
- (NSString *)foldingTableView:(FoldingTableView *)foldingTableView decriptionForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%lu",[[[self.showArray objectAtIndex:section] valueForKey:@"list"] count]];
}

//Cell
- (UITableViewCell *)foldingTableView:(FoldingTableView *)foldingTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *rowdic = [[[self.showArray objectAtIndex:indexPath.section] valueForKey:@"list"] objectAtIndex:indexPath.row];
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [foldingTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[rowdic valueForKey:@"name"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[rowdic valueForKey:@"id"]];
    
    return cell;
}

//选中的 cell
- (void)foldingTableView:(FoldingTableView *)foldingTableView didSelectedRowAtIndexpath:(NSIndexPath *)indexPath{
    [foldingTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"选中%@",indexPath);

}

//返回每组的背景色
- (UIColor *)foldingTableView:(FoldingTableView *)foldingTableView backgroundColorForHeaderInSection:(NSInteger)section{
    return [UIColor redColor];
}

@end
