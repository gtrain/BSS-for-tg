//
//  UserProfileViewController.m
//  BSS
//
//  Created by liuc on 13-9-23.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserTextInfoModifyViewController.h"
#import "UserInfoUnit.h"
#import "UserModel.h"
#import "AFNetEngine.h"

#define TITLE @"个人档案"

#define ALERT_TITLE @"提示"
#define TEXT_CONFIRM @"确定"
#define TEXT_CANCEL @"取消"

#define KEY_CAMERA @"camera"
#define KEY_PHOTOALBUM @"album"

#define KEY_ICONPATH @"iconpath"
#define NOTIFICATION_NAME @"iconchange"

@interface UserProfileViewController ()

@property (nonatomic, strong) UITableView *tblVProfile;
@property (nonatomic, strong) NSArray *arrayUnits;
@property (nonatomic, strong) NSDictionary *dicUnits;
@property (nonatomic, strong) UIImageView *imgvIcon;
@property (nonatomic, strong) UIImage *imgv;

@property (nonatomic, strong) UserModel *uModel;

@property (nonatomic, strong) NSMutableDictionary *cameraState;

@property (assign) BOOL isUncertinyReady;

@end

@implementation UserProfileViewController

#pragma Default method
-(void)loadView{
    [super loadView];
    
    [self prepareForFrame];
    
    [self setupLocalData];
    
    [self loadUncertainty];
    
}

#pragma Default method
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupUncertainty:_uModel];
}


//Prepare the frame including the base color etc.
-(void)prepareForFrame{
    [self.navigationItem setTitle:TITLE];
    
    //Back button
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundColor:[UIColor clearColor]];
    [btnBack setFrame:CGRectMake(10,10, 46, 27)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_orange_back"] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_orange_back_pressed"] forState:UIControlStateHighlighted];
    [btnBack setTitle:@" 返回" forState:UIControlStateNormal];
    [btnBack.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnBack addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setTag:100];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _tblVProfile = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    UIView *bgV = [[UIView alloc]initWithFrame:_tblVProfile.bounds];
    [bgV setBackgroundColor:[[UIColor alloc] initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    [_tblVProfile setBackgroundView:bgV];
    [self.view addSubview:_tblVProfile];
    
}

#pragma onClick event
-(void)onClick:(UIButton *)btn{
    switch(btn.tag){
        case 100:
            [self finishSelf];
            break;
    }
}

-(void)finishSelf{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//Set up the local data for controls
-(void)setupLocalData{
    _isUncertinyReady = NO;
    _arrayUnits = [NSArray arrayWithObjects:
                [[UserInfoUnit alloc]initWithSign:@"头像" content:@"" andEditable:YES],
                [[UserInfoUnit alloc]initWithSign:@"姓名" content:@"" andEditable:YES],
                [[UserInfoUnit alloc]initWithSign:@"性别" content:@"" andEditable:YES],
                [[UserInfoUnit alloc]initWithSign:@"职位" content:@"" andEditable:YES],
                [[UserInfoUnit alloc]initWithSign:@"公司名称" content:@"" andEditable:YES],
                [[UserInfoUnit alloc]initWithSign:@"手机" content:@"" andEditable:NO],
                [[UserInfoUnit alloc]initWithSign:@"邮箱" content:@"" andEditable:NO],
                [[UserInfoUnit alloc]initWithSign:@"QQ号码" content:@"" andEditable:YES],
                [[UserInfoUnit alloc]initWithSign:@"办公地址" content:@"" andEditable:YES], nil];
    
    _dicUnits = [NSDictionary dictionaryWithObjects:_arrayUnits forKeys:@[@"icon",@"name",@"gender",@"post",@"company",@"mobile",@"email",@"qqNum",@"bussiness_address"]];
    _tblVProfile.dataSource = self;
    _tblVProfile.delegate = self;
    _imgv = [UIImage imageNamed:@"icon_head_portrait"];
}

//Load Uncertainty from from the server or cache
-(void)loadUncertainty{
    NSLog(@"loadUncertainty");
    [[AFNetEngine shareEngine] opGetAllInfoOnSucceeded:^(JSONModel *aModelBaseObj) {
        if([aModelBaseObj isKindOfClass:[UserModel class]]){
            _uModel = (UserModel *)aModelBaseObj;
            [self setupUncertainty:_uModel];
            _isUncertinyReady = YES;
        }
    } onError:^(RESTError *engineError) {
        NSLog(@"Network error.");
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivedNotification:) name:NOTIFICATIONNAME_MODIFY object:nil];
}

-(void)receivedNotification:(NSNotification *)notification{
    NSLog(@"Received notification");
    NSDictionary *userInfo = [notification userInfo];
    NSLog(@"Content is:%@",userInfo);
    switch([[userInfo objectForKey:TEXT_KEY]integerValue]){
        case KEY_NAME_NUM:
            _uModel.name = [userInfo objectForKey:KEY_NAME];
            break;
        case KEY_POST_NUM:
            _uModel.post = [userInfo objectForKey:KEY_POST];
            break;
        case KEY_COMPANY_NUM:
            _uModel.company = [userInfo objectForKey:KEY_COMPANY];
            break;
        case KEY_QQ_NUM:
            _uModel.qq = [userInfo objectForKey:KEY_QQ];
            break;
        case KEY_ADDRESS_NUM:
            _uModel.business_address = [userInfo objectForKey:KEY_ADDRESS];
            break;
        default:
            //Do nothing
            break;
    }
    [self setupUncertainty:_uModel];
}

//Paint data into the views on the screen
-(void)setupUncertainty:(UserModel *)um{
    if(um != nil){
        [[_dicUnits objectForKey:@"name"] setSignContent:um.name];
        [[_dicUnits objectForKey:@"gender"] setSignContent:[self genderTransformFrom:um.gender]];
        [[_dicUnits objectForKey:@"post"] setSignContent:um.post];
        [[_dicUnits objectForKey:@"company"] setSignContent:um.company];
        [[_dicUnits objectForKey:@"mobile"] setSignContent:um.mobile];
        [[_dicUnits objectForKey:@"email"] setSignContent:um.email];
        [[_dicUnits objectForKey:@"qqNum"] setSignContent:um.qq];
        [[_dicUnits objectForKey:@"bussiness_address"] setSignContent:um.business_address];
    
        [_tblVProfile reloadData];
    }
}

//Gender transform
-(NSString *)genderTransformFrom:(NSString *)gender{
    if([gender isEqualToString:@"男"]){
        return @"0";
    }else if([gender isEqualToString:@"女"]){
        return @"1";
    }else if([gender isEqualToString:@"0"]){
        return @"男";
    }else if([gender isEqualToString:@"1"]){
        return @"女";
    }else{
        NSLog(@"Error:The income gender is %@",gender);
        return nil;
    }
}

//隐藏TabBar
-(id)hideTabBarWhenPushed{
    [self setHidesBottomBarWhenPushed:YES];
    return self;
}

#pragma UITableViewDataSource
//Start-------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        return [self tableView:tableView createIconCellForIndexPath:indexPath];
    }else{
        return [self tableView:tableView createNormalCellForIndexPath:indexPath];
    }
    
}

//Create a cell with icon position
-(UITableViewCell *)tableView:(UITableView *)tableView createIconCellForIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"iconCell";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    UserInfoUnit *unit = [_arrayUnits objectAtIndex:indexPath.row];
    if(unit.isEditTable){
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }else{
        UIView *acView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 9, 10)];
        [cell setAccessoryView:acView];
    }
    
    UIFont *font = [UIFont systemFontOfSize:12];
    [cell.textLabel setFont:font];
    [cell.textLabel setText:unit.sign];
    
    cell.backgroundColor = [UIColor clearColor];
    UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
    [bgV setBackgroundColor:[[UIColor alloc] initWithRed:1.0 green:150.0/255.0 blue:0 alpha:1.0]];
    [cell setSelectedBackgroundView:bgV];
    
    _imgvIcon = [[UIImageView alloc]initWithFrame:CGRectMake(cell.bounds.size.width-80, (cell.bounds.size.height-35)/2, 35, 35)];
    [_imgvIcon setImageWithURL:[NSURL URLWithString:[self obtainUserIconPath]] placeholderImage:_imgv];
    [_imgvIcon setHighlightedImage:_imgvIcon.image];
    [_imgvIcon setHighlighted:YES];
    [cell.contentView addSubview:_imgvIcon];
    
    return cell;
    
}

//Create a cell with value position
-(UITableViewCell *)tableView:(UITableView *)tableView createNormalCellForIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    UserInfoUnit *unit = [_arrayUnits objectAtIndex:indexPath.row];
    
    if(unit.isEditTable){
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }else{
        UIView *acView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 9, 10)];
        [cell setAccessoryView:acView];
    }
    UIFont *font = [UIFont systemFontOfSize:12];
    [cell.detailTextLabel setFont:font];
    [cell.detailTextLabel setText:unit.signContent];
    [cell.detailTextLabel setNumberOfLines:0];
    [cell.textLabel setFont:font];
    [cell.textLabel setText:unit.sign];
    
    cell.backgroundColor = [UIColor clearColor];
    UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
    [bgV setBackgroundColor:[[UIColor alloc] initWithRed:1.0 green:150.0/255.0 blue:0 alpha:1.0]];
    [cell setSelectedBackgroundView:bgV];
    
    return cell;
}
//End-----------------------------

#pragma UITableViewDelegate
//Start-------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(_isUncertinyReady){
    switch(indexPath.row){
        case 0:
            [self showTakePhotoSource];
            break;
        case 1:
            [self.navigationController pushViewController:[[[UserTextInfoModifyViewController alloc]initWithUserModel:_uModel forType:TypeName] hideTabBarWhenPushed] animated:YES];
            break;
        case 2:
            [self showGenderChosenAlert];
            break;
        case 3:
            [self.navigationController pushViewController:[[[UserTextInfoModifyViewController alloc]initWithUserModel:_uModel  forType:TypePost] hideTabBarWhenPushed] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[[[UserTextInfoModifyViewController alloc]initWithUserModel:_uModel  forType:TypeCompany] hideTabBarWhenPushed] animated:YES];
            break;
        case 5:
            //Do nothing
            break;
        case 6:
            //Do nothing
            break;
        case 7:
            [self.navigationController pushViewController:[[[UserTextInfoModifyViewController alloc]initWithUserModel:_uModel  forType:TypeQQNum] hideTabBarWhenPushed] animated:YES];
            break;
        case 8:
            [self.navigationController pushViewController:[[[UserTextInfoModifyViewController alloc]initWithUserModel:_uModel  forType:TypeBussinessAddress] hideTabBarWhenPushed] animated:YES];
            break;
    }
        
    }
    
}

-(void)showTakePhotoSource{
    _cameraState = [NSMutableDictionary dictionary];
    
    BOOL isCameraAvb = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL isPhotoAlbumAvb = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    if(isCameraAvb && isPhotoAlbumAvb){
        UIAlertView *alertBoth = [[UIAlertView alloc] initWithTitle:@"获取图片" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册",@"拍照", nil];
        [alertBoth setTag:101];
        [alertBoth show];
    }else if(isCameraAvb){
        [self triggerCameraPhotoPickerController];
    }else if(isPhotoAlbumAvb){
        [self triggerPhotoAlbumPickerController];
    }else{
        UIAlertView *alertError = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有可用的设备" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertError show];
    }
    
}

-(void)triggerPhotoAlbumPickerController{
    UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
    pickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerCtrl.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerCtrl.sourceType];
    pickerCtrl.delegate = self;
    pickerCtrl.allowsEditing = NO;
    [self presentModalViewController:pickerCtrl animated:YES];
}

-(void)triggerCameraPhotoPickerController{
    UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
    pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerCtrl.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerCtrl.sourceType];
    pickerCtrl.delegate = self;
    pickerCtrl.allowsEditing = NO;
    [self presentModalViewController:pickerCtrl animated:YES];
}


-(void)triggerCropperImageController:(UIImage *)image{
    ImageCropViewController *cropCtrl = [[[ImageCropViewController alloc]initWithImage:image]hidesTabBarWhenPushed];
    cropCtrl.delegate = self;
    [self.navigationController pushViewController:cropCtrl animated:YES];
}

-(void)showGenderChosenAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"性别" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"男",@"女", nil];
    [alert setTag:100];
    [alert show];
    
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self triggerCropperImageController:image];
}

#pragma ImageCropViewControllerDelegate
-(void)onFinishCropping:(UIImage *)image{
    [[AFNetEngine shareEngine]opUpdateUserFace:image onSucceeded:^(NSDictionary *dictionary) {
        _imgv = image;
        [_tblVProfile reloadData];
        [self saveUserIconPath:[dictionary objectForKey:@"face_path"]];
        
        [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:NOTIFICATION_NAME object:nil userInfo:nil]];
    } onError:^(RESTError *engineError) {
        [self showErrorTipsAlertWithMessage:engineError.errorDescription];
    }];
}

-(void)saveUserIconPath:(NSString *)path{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:path forKey:KEY_ICONPATH];
    [defaults synchronize];
}

-(NSString *)obtainUserIconPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_ICONPATH];
}

//End-----------------------------

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 100:
            [self processGenderOptionEvent:buttonIndex];
            break;
        case 101:
            [self processObtainImageMethodEvent:buttonIndex];
            break;
        default:
            //Do nothing
            break;
    }
}

-(void)processGenderOptionEvent:(NSInteger)index{
    switch(index){
        case 1:
            [self modifyGender:@"0"];
            NSLog(@"Modify to 0.");
            break;
        case 2:
            [self modifyGender:@"1"];
            NSLog(@"Modify to 1.");
            break;
        default:
            //Do nothing
            break;
            
    }
}

-(void)processObtainImageMethodEvent:(NSInteger) index{
    switch (index) {
        case 1:
            //Album
            break;
        case 2:
            //Camera
            break;
        default:
            //Do nothing
            break;
    }
}


//弹出错误提示对话框
-(void)showErrorTipsAlertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:message delegate:nil cancelButtonTitle:TEXT_CONFIRM otherButtonTitles:nil, nil];
    [alertView show];
}

//修改性别
-(void)modifyGender:(NSString *)gender{
    if(![gender isEqualToString:_uModel.gender]){
    [[AFNetEngine shareEngine] opUpdateUserGender:gender onSucceeded:^(NSDictionary *dictionary) {
        NSLog(@"Gender modified to %@",gender);
        _uModel.gender = gender;
        [self setupUncertainty:_uModel];
    } onError:^(RESTError *engineError) {
        NSLog(@"Error modify gender failed.%@",engineError.errorDescription);
    }];
    }
}


@end
