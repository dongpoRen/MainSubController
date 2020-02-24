//
//  ThreeViewController.m
//  主子控制器
//
//  Created by SuShi on 2020/2/25.
//  Copyright © 2020 SuShi. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UIViewControllerProtocol
>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThree"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellThree"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Three-第%ld行", indexPath.row];
    
    return cell;
}

#pragma mark - UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([self.scrollViewDelegate respondsToSelector:@selector(childScrollViewDidScroll:)]) {
        [self.scrollViewDelegate childScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}


#pragma mark - UIViewControllerDelegate

- (void)updateContentOffset:(CGPoint)offset {
    
    [self.tableView setContentOffset:offset];
}

- (CGFloat)getContentOffsetY {
    return self.tableView.contentOffset.y;
}

#pragma mark - Lazy load

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
@end
