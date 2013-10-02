//
//  ViewController.h
//  BSS
//
//  Created by YANGZQ on 13-9-11.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoVC : UIViewController<UIActionSheetDelegate>

- (IBAction)requestUDID:(id)sender;
- (IBAction)uninstall:(id)sender;

- (IBAction)requestToken:(id)sender;
- (IBAction)refreshToken:(id)sender;


- (IBAction)location:(id)sender;
- (IBAction)locationAreaData:(id)sender;
- (IBAction)cancelArea:(id)sender;

- (IBAction)classify:(id)sender;
- (IBAction)cancelClassify:(id)sender;
- (IBAction)classifyCacheData:(id)sender;

- (IBAction)valid:(id)sender;
- (IBAction)cancelValidMobile:(id)sender;

- (IBAction)questValidCode:(id)sender;
- (IBAction)cancelQuestValidCode:(id)sender;

- (IBAction)verify:(id)sender;
- (IBAction)cancelVerify:(id)sender;

- (IBAction)regUserInfo:(id)sender;
- (IBAction)cancelUserReg:(id)sender;

- (IBAction)forgotVfMobile:(id)sender;
- (IBAction)cancelVfMobile:(id)sender;

- (IBAction)getCodeFG:(id)sender;
- (IBAction)cancelGetCodeFG:(id)sender;

- (IBAction)verifyCodeFG:(id)sender;
- (IBAction)cancelVerifyCodeFG:(id)sender;

- (IBAction)updateInfo:(id)sender;
- (IBAction)cancelUpdate:(id)sender;

- (IBAction)getAllInfo:(id)sender;
- (IBAction)cancelAllInfo:(id)sender;

- (IBAction)baseInfo:(id)sender;
- (IBAction)cancelBaseInfo:(id)sender;

- (IBAction)serverInfo:(id)sender;
- (IBAction)cancelServerInfo:(id)sender;

- (IBAction)markLogin:(id)sender;
- (IBAction)markLogout:(id)sender;
- (IBAction)markStart:(id)sender;
- (IBAction)markClose:(id)sender;


- (IBAction)cName:(id)sender;
- (IBAction)cGender:(id)sender;
- (IBAction)cQQ:(id)sender;
- (IBAction)cAddr:(id)sender;
- (IBAction)cCompany:(id)sender;
- (IBAction)cPost:(id)sender;



- (IBAction)dismissView:(id)sender;


@end













