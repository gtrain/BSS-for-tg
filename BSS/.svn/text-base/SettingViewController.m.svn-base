//
//  SettingViewController.m
//  BSS
//
//  Created by liuc on 13-9-22.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "SettingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UserModel.h"
#import "UserProfileViewController.h"
#import "ProjAreaViewController.h"
#import "ProjectTypeOptionViewController.h"
#import "UserFeedBackViewController.h"
#import "AppInfoViewController.h"
#import "UserNoInfoViewController.h"
#import "FunctionsIntroViewController.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"

#define NOTIFICATION_NAME @"iconchange"
#define KEY_ICONPATH @"iconpath"

@interface SettingViewController ()



@property (nonatomic, strong) UIImageView *imgUserIcon;
@property (nonatomic, strong) NSString *userIconLink;
@property (nonatomic, strong) UILabel *lblUserName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) UILabel *lblUserPost;
@property (nonatomic, strong) NSString *userPost;
@property (nonatomic, strong) UILabel *lblUserCompany;
@property (nonatomic, strong) NSString *userCompany;
@property (nonatomic, strong) UIView *userInfoComponent;
@property (nonatomic, strong) UILabel *lblAppLevel;
@property (nonatomic, strong) NSString *appLevel;

@property (nonatomic, strong) UIView *btnLogoutComponent;
@property (nonatomic, strong) UIButton *btnLogout;

@property (assign) CGFloat width;
@property (assign) CGFloat height;

@property (nonatomic, strong) NSDictionary *dicForMapping;
@property (nonatomic, strong) NSString *idProfile;
@property (nonatomic, strong) NSString *idProject;
@property (nonatomic, strong) NSString *idApp;


@end

@implementation SettingViewController

-(void)loadView{
    
    [super loadView];
    
    
    [self prepareFrame];
    [self setupLocalData];
    
    [self setupSettingOptions];
    [self setupLogoutButton];
    
    [self loadUncertainty];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}

//Prepare the frame of the UI
-(void)prepareFrame{
    _width = self.view.bounds.size.width;
    _height = self.view.bounds.size.height;
    
    [self.navigationItem setTitle:@"设置"];
    _tableViewSetting = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, _width, _height-90) style:UITableViewStyleGrouped];
    UIView *bgV = [[UIView alloc]initWithFrame:_tableViewSetting.bounds];
    [bgV setBackgroundColor:[[UIColor alloc] initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    
    [_tableViewSetting setBackgroundView:bgV];
    
    [self.view addSubview:_tableViewSetting];
    
    
    //Init a component for user info views
    _userInfoComponent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 70)];
    [_userInfoComponent setBackgroundColor:[UIColor clearColor]];
    [_tableViewSetting setTableHeaderView:_userInfoComponent];
    
    //Default image
    _imgUserIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    _imgUserIcon.layer.cornerRadius = 5.0f;
    [_imgUserIcon setImage:[UIImage imageNamed:@"icon_head_portrait" ]];
    [_userInfoComponent addSubview:_imgUserIcon];
    
}

-(void)receiveUserIconChangedNotification:(NSNotification *)notification{
    NSLog(@"received");
    [_imgUserIcon setImageWithURL:[NSURL URLWithString:[self obtainUserIconPath]]];
    
}

//User info summary
-(void)setupPartsOfUserInfo{
    
    [_imgUserIcon setImageWithURL:[NSURL URLWithString:[self obtainUserIconPath]]];
    
    //User Name
    UIFont *lunfont = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    CGSize lunSize = [self obtainCGSizeOfLabelInWrapStateByString:_userName andFont:lunfont];
    _lblUserName = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, lunSize.width, lunSize.height)];
    [_lblUserName setNumberOfLines:0];
    [_lblUserName setBackgroundColor:[UIColor clearColor]];
    [_lblUserName setText:_userName];
    [_lblUserName setFont:lunfont];
    [_userInfoComponent addSubview:_lblUserName];
    
    //User Post
    UIFont *pfont = [UIFont systemFontOfSize:12];
    CGSize pSize = [self obtainCGSizeOfLabelInWrapStateByString:_userPost andFont:pfont];
    _lblUserPost = [[UILabel alloc]initWithFrame:CGRectMake(70+lunSize.width, 10+lunSize.height-pSize.height, pSize.width, pSize.height)];
    [_lblUserPost setNumberOfLines:0];
    [_lblUserPost setBackgroundColor:[UIColor clearColor]];
    [_lblUserPost setFont:pfont];
    [_lblUserPost setText:_userPost];
    [_userInfoComponent addSubview:_lblUserPost];
    
    //User company
    UIFont *cpnfont = [UIFont systemFontOfSize:12];
    CGSize cpnSize = [self obtainCGSizeOfLabelInWrapStateByString:_userCompany andFont:cpnfont];
    _lblUserCompany = [[UILabel alloc]initWithFrame:CGRectMake(70, 10+lunSize.height , cpnSize.width, cpnSize.height)];
    [_lblUserCompany setNumberOfLines:0];
    [_lblUserCompany setBackgroundColor:[UIColor clearColor]];
    [_lblUserCompany setText:_userCompany];
    [_lblUserCompany setFont:cpnfont];
    [_userInfoComponent addSubview:_lblUserCompany];
    
}


-(NSString *)obtainUserIconPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_ICONPATH];
}

//Size of Wrap Text Content
-(CGSize)obtainCGSizeOfLabelInWrapStateByString:(NSString *)content andFont:(UIFont *)font{
    CGSize vtlSize = CGSizeMake(320, 1000);
    CGSize actSize = [content sizeWithFont:font constrainedToSize:vtlSize lineBreakMode:UILineBreakModeWordWrap];
    return actSize;
    
}
//Link the tableview and its processor
-(void)setupSettingOptions{
    _tableViewSetting.dataSource = self;
    _tableViewSetting.delegate = self;
}

//The last part of the screen
-(void)setupLogoutButton{
    _btnLogoutComponent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 80)];
    [_btnLogoutComponent setBackgroundColor:[UIColor clearColor]];
    
    _btnLogout= [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnLogout setBackgroundColor:[UIColor clearColor]];
    [_btnLogout setTitle:@"退出登录" forState:UIControlStateNormal];
    [_btnLogout setFrame:CGRectMake(30, 10, _width-60, 44)];
    _btnLogout.layer.cornerRadius = 5.0f;
    [_btnLogout setBackgroundImage:[UIImage imageNamed:@"logout_btn_bg"] forState:UIControlStateNormal];
    [_btnLogout setBackgroundImage:[UIImage imageNamed:@"logout_btn_bg_pressed"] forState:UIControlStateHighlighted];
    [_btnLogout addTarget:self action:@selector(btnPressToLogout:) forControlEvents:UIControlEventTouchUpInside];
    [_tableViewSetting setTableFooterView:_btnLogoutComponent];
    [_btnLogoutComponent addSubview:_btnLogout];
}

-(void)btnPressToLogout:(UIButton *)button
{
    [AppDelegateShare.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}

//Init all the local data to be showed on this screen
-(void)setupLocalData{
    NSArray *arrayProfile = @[@"个人档案",@"帐号信息"];
    NSArray *arrayProject = @[@"跟进的项目地区",@"跟进的项目类型"];
    NSArray *arrayApp = @[@"版本更新",@"功能介绍",@"意见反馈",@"关于"];
    
    _idApp = @"app";
    _idProfile = @"profile";
    _idProject = @"project";
    _dicForMapping = [NSDictionary dictionaryWithObjectsAndKeys:arrayProfile,_idProfile,arrayProject,_idProject,arrayApp,_idApp, nil];
    _appLevel = @"v1.0";
}

-(void)setupAccordingToNetworkThatName:(NSString *)name post:(NSString *)post company:(NSString *)company{
    
    //Obtain user info
    _userName = name;
    if(post != nil && post.length > 0){
       _userPost = [[NSString alloc]initWithFormat:@"(%@)", post ]  ;
    }else{
        _userPost = @"";
    }
    _userCompany = company;
}

-(void)loadUncertainty{
    [[AFNetEngine shareEngine] opGetAllInfoOnSucceeded:^(JSONModel *aModelBaseObj) {
        if([aModelBaseObj isKindOfClass:[UserModel class]]){
            UserModel *uModel = (UserModel *)aModelBaseObj;
            [self setupAccordingToNetworkThatName:uModel.name post:uModel.post company:uModel.company];
            [self setupPartsOfUserInfo];
        }
    } onError:^(RESTError *engineError) {
        NSLog(@"Network error.");
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveUserIconChangedNotification:) name:NOTIFICATION_NAME object:nil];
}

#pragma UITableViewDataSource
//Start----------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int size = 0;
    switch(section){
        case SECTION_PROFILE:
            size = ((NSArray *)[_dicForMapping objectForKey:_idProfile]).count;
            break;
        case SECTION_PROJECT:
            size = ((NSArray *)[_dicForMapping objectForKey:_idProject]).count;
            break;
        case SECTION_APP:
            size = ((NSArray *)[_dicForMapping objectForKey:_idApp]).count;
            break;
    }
    return size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    NSString *content ;
    switch(indexPath.section){
        case SECTION_PROFILE:
            content = [[_dicForMapping objectForKey:_idProfile] objectAtIndex:indexPath.row];
            break;
        case SECTION_PROJECT:
            content = [[_dicForMapping objectForKey:_idProject] objectAtIndex:indexPath.row];
            break;
        case SECTION_APP:
            content = [[_dicForMapping objectForKey:_idApp] objectAtIndex:indexPath.row];
            break;
    }
    
    cell.textLabel.text = content;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
    [bgV setBackgroundColor:[[UIColor alloc] initWithRed:1.0 green:150.0/255.0 blue:0 alpha:1.0]];
    [cell setSelectedBackgroundView:bgV];
    
    if([content isEqualToString:[[_dicForMapping objectForKey:_idApp]objectAtIndex:3]]){
        cell.detailTextLabel.text = _appLevel;
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
    }else{
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == SECTION_PROJECT){
        return @"项目订制";
    }
    return nil;
}

//End-------------------------------------------------

#pragma UITableViewDelegate
//Start-----------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.tabBarController hidesBottomBarWhenPushed];
    switch(indexPath.section){
        case SECTION_PROFILE:
            [self arrangeTaskForSectionProfileInRow:indexPath.row];
            break;
        case SECTION_PROJECT:
            [self arrangeTaskForSectionProjectInRow:indexPath.row];
            break;
        case SECTION_APP:
            [self arrangeTaskForSectionAppInRow:indexPath.row];
            break;
    }
}

-(void)arrangeTaskForSectionProfileInRow:(int )row{
    switch(row){
        case 0:{
            [[self navigationController]pushViewController:[[[UserProfileViewController alloc]init] hideTabBarWhenPushed] animated:YES];
             break;
            } 
        case 1:
        {
            UserNoInfoViewController *userInfo=[[UserNoInfoViewController alloc] init];
            [userInfo setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:userInfo animated:YES];
            break;
        }
    }
}

-(void)arrangeTaskForSectionProjectInRow:(int)row{
    switch(row){
        case 0:
        {
            ProjAreaViewController *projArea=[[ProjAreaViewController alloc] init];
            [projArea setHidesBottomBarWhenPushed:YES];
            [[self navigationController]pushViewController:projArea animated:YES];
            break;
        }
        case 1:
            [[self navigationController]pushViewController:[[[ProjectTypeOptionViewController alloc]init] hideTabBarWhenPushed] animated:YES];
            break;
    }
}

-(void)arrangeTaskForSectionAppInRow:(int)row{
    switch(row){
        case 0:
            break;
        case 1:
            [[self navigationController]pushViewController:[[[FunctionsIntroViewController alloc]init] hidesTopBar:YES bottomBar:YES] animated:YES];
            break;
        case 2:
            [[self navigationController]pushViewController:[[[UserFeedBackViewController alloc]init] hideTabBarWhenPushed] animated:YES];
            break;
        case 3:
            [[self navigationController]pushViewController:[[[AppInfoViewController alloc]init]hideTabBarWhenPushed] animated:YES];
            break;
    }
}
//End-------------------------------------------------
@end
