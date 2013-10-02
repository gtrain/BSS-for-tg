//
//  ProjectTypeOptionViewController.m
//  BSS
//
//  Created by liuc on 13-9-25.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "ProjectTypeOptionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CheckBox.h"

#define TITLE @"选择项目类型"

#define TEXT_BACK @"  返回"
#define TEXT_UPLOAD @"提交"
#define NAME_IMG_BACK_NORMAL @"button_orange_back"
#define NAME_IMG_BACK_HIGHTLIGHTED @"button_orange_back_pressed"
#define NAME_IMG_UPLOAD_NORMAL @"button_orange_square"
#define NAME_IMG_UPLOAD_HIGHTLITED @"button_orange_square_pressed"

#define ALERT_TITLE @"提示"
#define TEXT_CONFIRM @"确定"
#define TEXT_CANCEL @"取消"

#define OPTION_TIP @"    最多可以选择3个项目类型。"
#define ERROR_OPTION_LESSTHANONE @"请选择至少一个项目类型"
#define NAME_IMG_OPTION_TIP_BACKGROUND @"pro_type_opts_tip_back"
#define OPTION_TIP_MAXCOUNT @"您已经选择了3个跟进的项目类型，请选择3个与您最相关的项目类型，以便我们更精准地推荐项目给您。"

#define ITEM_CHECKED @"checked"

@interface ProjectTypeOptionViewController ()

@property (nonatomic, strong) UITableView *tblvOptions;
@property (nonatomic, strong) UILabel *lblOptionsTip;
@property (assign) BOOL isUncertaintyReady;
@property (assign) BOOL typeOptionModified;

@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSMutableArray *checkedArray;
@property (assign) int checkedCount;

@end

@implementation ProjectTypeOptionViewController

-(void)loadView{
    [super loadView];
    
    [self prepareFrame];
    
    [self initLocalData];
    
    [self initUncertainty];
    
}

//总体框架
-(void)prepareFrame{
    [self.navigationItem setTitle:TITLE];
    
    [self.view setBackgroundColor:[[UIColor alloc] initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    
    //Back button
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundColor:[UIColor clearColor]];
    [btnBack setFrame:CGRectMake(10,10, 46, 27)];
    [btnBack setBackgroundImage:[UIImage imageNamed:NAME_IMG_BACK_NORMAL] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:NAME_IMG_BACK_HIGHTLIGHTED] forState:UIControlStateHighlighted];
    [btnBack setTitle:TEXT_BACK forState:UIControlStateNormal];
    [btnBack.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnBack addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setTag:100];
    
    //Upload button
    UIButton *btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnUpload setBackgroundColor:[UIColor clearColor]];
    [btnUpload setFrame:CGRectMake(10,10, 46, 27)];
    [btnUpload setBackgroundImage:[UIImage imageNamed:NAME_IMG_UPLOAD_NORMAL] forState:UIControlStateNormal];
    [btnUpload setBackgroundImage:[UIImage imageNamed:NAME_IMG_UPLOAD_HIGHTLITED] forState:UIControlStateHighlighted];
    [btnUpload setTitle:TEXT_UPLOAD forState:UIControlStateNormal];
    [btnUpload.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnUpload setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnUpload addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnUpload setTag:101];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btnUpload];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    //提示语句控件
    _lblOptionsTip = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width , 44)];
    [_lblOptionsTip setBackgroundColor:[UIColor clearColor]];
    [_lblOptionsTip setText:OPTION_TIP];
    UIColor *tipBack = [UIColor colorWithPatternImage:[UIImage imageNamed:NAME_IMG_OPTION_TIP_BACKGROUND]];
    [_lblOptionsTip setBackgroundColor:tipBack];
    [_lblOptionsTip setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_lblOptionsTip];
    
    //选项内容
    _tblvOptions = [[UITableView alloc]initWithFrame:CGRectMake(0, _lblOptionsTip.bounds.size.height, width, height-_lblOptionsTip.bounds.size.height-self.navigationController.navigationBar.bounds.size.height) style:UITableViewStylePlain];
    [_tblvOptions setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tblvOptions];
    
}

//获取本地数据
-(void)initLocalData{
    [[AFNetEngine shareEngine] opProjectClassify:YES onSucceeded:^(NSArray *dicArray) {
        [self setupLocalData:dicArray];
    } onError:^(RESTError *engineError) {
        [self showErrorTipsAlertWithMessage:engineError.errorDescription];
    }];
}

//本地数据初始化
-(void)setupLocalData:(NSArray *)array{
    _typeArray = array;
    _checkedArray = [NSMutableArray array];
    _checkedCount = 0;
    _typeOptionModified = NO;
    int count = array.count;
    for(int i= 0;i<count;i++){
        [_checkedArray addObject:[NSNumber numberWithBool:NO]];
    }
    
    _tblvOptions.dataSource = self;
    _tblvOptions.delegate = self;
}

//获取用户选择过的信息，可能在服务器端或者本地有保留，为不确定数据，将其值加入每一个单元内，BOOL类型
-(void)initUncertainty{
    [[AFNetEngine shareEngine]opGetSubInfoOnSucceeded:^(NSDictionary *dictionary) {
        [self setIsUncertaintyReady:YES];
        [self setupUncertainty:[dictionary objectForKey:@"type"]];
        NSLog(@"%@",dictionary);
        [_tblvOptions reloadData];
    } onError:^(RESTError *engineError) {
        NSLog(@"Network error.%@",engineError.errorDescription);
    }];
}

//将获取的数据赋予控件
-(void)setupUncertainty:(NSString *)types{
    int count = _checkedArray.count;
    NSString *tempNO = nil;
    for(int i = 0;i < count;i ++){
        tempNO = [_typeArray[i] objectForKey:@"no"];
        if(tempNO != nil){
            if([types rangeOfString:tempNO].length > 0){
                [self checkExchange:i];
            }
        }
    }
}

//弹出错误提示对话框
-(void)showErrorTipsAlertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:message delegate:nil cancelButtonTitle:TEXT_CONFIRM otherButtonTitles:nil, nil];
    [alertView show];
}

//点击事件响应
-(void)onClick:(UIButton *)btn{
    switch(btn.tag){
        case 100:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 101:
            //Upload option info
            [self uploadProjectTypeSubscription];
            break;
    }
}

//提交订阅的项目类型
-(void)uploadProjectTypeSubscription{
    if(_typeOptionModified){
        NSString *types = @"";
        NSString *typeTemp = nil;
        int len = _checkedArray.count;
        for(int i = 0; i < len; i++){
            if([_checkedArray[i]boolValue]){
                typeTemp = [[_typeArray objectAtIndex:i] objectForKey:@"no"];
                if(typeTemp != nil && [typeTemp isKindOfClass:[NSString class]])
                    types = [types stringByAppendingFormat:@"%@,",typeTemp];
            }
        }
        if(types.length <1){
            [self showErrorTipsAlertWithMessage:ERROR_OPTION_LESSTHANONE];
            return;
        }
        [[AFNetEngine shareEngine]opSetSubType:types onSucceeded:^(NSDictionary *dictionary) {
            NSLog(@"Uploaded.%@",dictionary);
            [self.navigationController popViewControllerAnimated:YES];
        } onError:^(RESTError *engineError) {
            [self showErrorTipsAlertWithMessage:engineError.errorDescription];
            NSLog(@"Error:%@",engineError.errorDescription);
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        CheckBox *chk = [[CheckBox alloc]initWithFrame:CGRectMake(0, 5, cell.bounds.size.width , cell.bounds.size.height) checked:NO];
        [chk setTag:100];
        [cell.contentView addSubview:chk];
    }
    UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
    [bgV setBackgroundColor:[[UIColor alloc] initWithRed:1.0 green:150.0/255.0 blue:0 alpha:1.0]];
    [cell setSelectedBackgroundView:bgV];
    
    CheckBox *chkBox = (CheckBox *)[cell viewWithTag:100];
    [chkBox setText:[[_typeArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [chkBox setChecked:[_checkedArray[indexPath.row] boolValue]];
    
    return cell;
}

//隐藏TabBar
-(id)hideTabBarWhenPushed{
    [self setHidesBottomBarWhenPushed:YES];
    return self;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!_typeOptionModified){
        _typeOptionModified = YES;
    }
    [self checkExchange:indexPath.row];
    [_tblvOptions reloadData];
}

//对调选项
-(void)checkExchange:(int)row{
    NSLog(@"Checked row may be row %d.",row);
    if(_isUncertaintyReady){
        BOOL isChecked = [_checkedArray[row] boolValue];
        if(!isChecked){
            if(_checkedCount+1 > 3){
                [self showErrorTipsAlertWithMessage:OPTION_TIP_MAXCOUNT];
                return ;
            }
            _checkedCount ++;
        }else{
            _checkedCount --;
        }
        _checkedArray[row] =[NSNumber numberWithBool: !isChecked];
    }
}


@end
