//
//  MainViewController.m
//  BSS
//
//  Created by YANGZQ on 13-9-16.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController (){
    NSArray *_iconNameArr;
    NSArray *_itemNameArr;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=_tabTitle;
    UISearchBar *searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenBoundsSize.width, kNavBarHeight)];
    [searchBar setDelegate:self];
    [searchBar setPlaceholder:@"搜索（请输入项目关键字）"];
    [searchBar setTintColor:[UIColor colorWithWhite:.8 alpha:.5]];
    [self.view addSubview:searchBar];
    
    self.itemTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenBoundsSize.width, kScreenBoundsSize.height)];
    [_itemTable setDelegate:self];
    [_itemTable setDataSource:self];
    [_itemTable setRowHeight:kRowHeight];
    _itemTable.scrollEnabled=NO;
    [_itemTable setBackgroundColor:[UIColor clearColor]];
    [_itemTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_itemTable];
    _iconNameArr=@[@"resource.bundle/icon_project_msg",@"resource.bundle/icon_find_project",@"resource.bundle/icon_update_project"];
    _itemNameArr=@[@"工程信息订阅",@"找项目",@"我的项目更新"];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark --UITableViewDelegate UITableViewDataSource--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MainItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        //[cell setSelectedBackgroundView:nil];
        
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((kRowHeight-48)/2,(kRowHeight-48)/2, 48, 48)];
        [imgView setTag:0];
        //[imgView setBackgroundColor:[UIColor colorWithRed:26/255.0 green:174/255.0 blue:206/255.0 alpha:1.0]];
        [imgView.layer setCornerRadius:6];
        [cell.contentView addSubview:imgView];

        UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, kRowHeight-1, kScreenBoundsSize.width, 1)];
        [lineLabel setBackgroundColor:[UIColor colorWithWhite:.8 alpha:1.0]];
        [cell.contentView addSubview:lineLabel];
    }
    
    UIImageView *iconView=(UIImageView *)[cell viewWithTag:0];
    [iconView setImage:[UIImage imageNamed:_iconNameArr[indexPath.row]]];
    cell.textLabel.text = _itemNameArr[indexPath.row];
    return cell;
}
#pragma mark --UISearchBarDelegate--

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController *search=[SearchViewController new];
    [search setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:search animated:NO];
    
    return NO;
}

@end
