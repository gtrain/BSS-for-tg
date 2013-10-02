//
//  MyProjectViewController.m
//  BSS
//
//  Created by YANGZQ on 13-9-16.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "MyProjectViewController.h"
#import "LoginViewController.h"

@interface MyProjectViewController ()

@end

@implementation MyProjectViewController

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
    self.title=_tabTitle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
