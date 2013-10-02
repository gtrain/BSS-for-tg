//
//  ProjectSDKDemo.m
//  BSS
//
//  Created by YANGZQ on 13-9-26.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "ProjectSDKDemo.h"
#import "AFNetEngine.h"

@implementation ProjectSDKDemo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setRssLocal:(id)sender {
    [[AFNetEngine shareEngine] opSetSubRegion:@"1.6,1.5,1.11.6,1.11.3,1.4.7,1.11.8" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"设置订阅地区： %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)setRsstype:(id)sender {
    [[AFNetEngine shareEngine] opSetSubType:@"2.1.10,2.1.5,2.1.1" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"设置订阅类型： %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)setLocTypeBoth:(id)sender {
    [[AFNetEngine shareEngine] opSetSubType:@"2.1.10,2.1.5,2.1.1" region:@"1.6,1.5,1.11.6,1.11.3,1.4.7,1.11.8" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"设置订阅类型： %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}



- (IBAction)getUserRssProperty:(id)sender {
    [[AFNetEngine shareEngine] opGetSubInfoOnSucceeded:^(NSDictionary *dictionary) {
        DLog(@"订阅信息 %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)geProjectNewsList:(id)sender {
    [[AFNetEngine shareEngine] opGetSubProjectListWithPage:nil count:nil onSucceeded:^(NSArray *modelArray, NSDictionary *info) {
        DLog(@"最新的项目信息 %d 条，其他信息 ：%@",modelArray.count,info);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)getSearchList:(id)sender {
    [[AFNetEngine shareEngine] opSearchProjectWithPage:nil count:nil region:nil keyword:@"广州" type:nil OnSucceeded:^(NSArray *modelArray, NSDictionary *info) {
        DLog(@"搜索到的项目信息 %d 条，其他信息 ：%@",modelArray.count,info);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)ProjectInfor:(id)sender {
    [[AFNetEngine shareEngine] opQueryProjectDetailWithId:@"43490" onSucceeded:^(JSONModel *aModelBaseObj) {
        if ([aModelBaseObj isKindOfClass:[ProjectDetailModel class]]) {
            ProjectDetailModel *detail=(ProjectDetailModel *) aModelBaseObj;
            DLog(@"查看的项目id是 %@, 联系人有 %d 位",detail.projid, detail.contsModelArray.count);
        }
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)signProjectLooked:(id)sender {
    [[AFNetEngine shareEngine] opSignViewTimeWithId:@"43490" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"id 43490 标记已看：%@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

//已付费查看的项目
- (IBAction)getProjectListLooked:(id)sender {
    [[AFNetEngine shareEngine] opGetCostProjListWithPage:nil count:nil onSucceeded:^(NSArray *modelArray, NSDictionary *info) {
        DLog(@"已付费的项目信息 %d 条，其他信息 ：%@",modelArray.count,info);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)collectProjectInfo:(id)sender {
    [[AFNetEngine shareEngine] opFavAddWithId:@"43490" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"id 43490 收藏：%@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)unCollectProjectInfo:(id)sender {
    [[AFNetEngine shareEngine] opFavRemoveWithId:@"43490" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"id 43490 取消收藏：%@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}


//收藏列表
- (IBAction)getCollectProjectList:(id)sender {
    [[AFNetEngine shareEngine] opGetFavProjListWithPage:nil count:nil onSucceeded:^(NSArray *modelArray, NSDictionary *info) {
        DLog(@"收藏的项目信息 %d 条，其他信息 ：%@",modelArray.count,info);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)payForProjectInfo:(id)sender {
    [[AFNetEngine shareEngine] opPayProjectDetailWithId:@"43490" onSucceeded:^(JSONModel *aModelBaseObj) {
        if ([aModelBaseObj isKindOfClass:[ProjectDetailModel class]]) {
            ProjectDetailModel *detail=(ProjectDetailModel *) aModelBaseObj;
            DLog(@"付费-查看的项目id %@, 联系人有 %d 位",detail.projid, detail.contsModelArray.count);
        }
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)getMyProjectList:(id)sender {
    [[AFNetEngine shareEngine] opGetFavUpdateListWithPage:nil count:nil onSucceeded:^(NSArray *modelArray, NSDictionary *info) {
        DLog(@"我的的项目信息 %d 条，其他信息 ：%@",modelArray.count,info);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

//反馈
- (IBAction)feelback:(id)sender {
    [[AFNetEngine shareEngine] opFeedbackMessage:nil onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"发布反馈意见：%@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

//头像
- (IBAction)setUserFace:(id)sender {
    UIImage *faceImg=[UIImage imageNamed:@"face"];
    
    [[AFNetEngine shareEngine] opUpdateUserFace:faceImg onSucceeded:^(NSDictionary *dictionary) {
        
        NSString *faceImgUrl=[dictionary objectForKey:@"face_path"];
        
        //设置image 到imageView
        [_faceView setImageWithURL:[NSURL URLWithString:faceImgUrl]];
        
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];

}



- (IBAction)oaPage:(id)sender {
    DemoVC *oaPage=[DemoVC new];
    [self presentModalViewController:oaPage animated:YES];
}


- (IBAction)paymentPress:(id)sender {
    [[AFNetEngine shareEngine] opPaymentWithArea:@"1.24" onSucceeded:^(NSString *aString) {
        DLog(@"支付返回信息是：%@",aString);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
    
}

@end




