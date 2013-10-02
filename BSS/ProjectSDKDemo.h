//
//  ProjectSDKDemo.h
//  BSS
//
//  Created by YANGZQ on 13-9-26.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoVC.h"
#import "ProjectDetailModel.h"

#import "UIImageView+AFNetworking.h"

@interface ProjectSDKDemo : UIViewController
- (IBAction)setRssLocal:(id)sender;
- (IBAction)setRsstype:(id)sender;
- (IBAction)setLocTypeBoth:(id)sender;

- (IBAction)getUserRssProperty:(id)sender;
- (IBAction)geProjectNewsList:(id)sender;
- (IBAction)getSearchList:(id)sender;


- (IBAction)ProjectInfor:(id)sender;
- (IBAction)getProjectListLooked:(id)sender;

- (IBAction)collectProjectInfo:(id)sender;
- (IBAction)unCollectProjectInfo:(id)sender;

- (IBAction)signProjectLooked:(id)sender;
- (IBAction)getCollectProjectList:(id)sender;
- (IBAction)payForProjectInfo:(id)sender;
- (IBAction)getMyProjectList:(id)sender;

- (IBAction)feelback:(id)sender;

- (IBAction)oaPage:(id)sender;

- (IBAction)setUserFace:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *faceView;

- (IBAction)paymentPress:(id)sender;




@end

















