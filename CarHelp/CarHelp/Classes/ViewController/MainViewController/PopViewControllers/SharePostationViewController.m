//
//  SharePostationViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-11.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "SharePostationViewController.h"

@interface SharePostationViewController ()

@end

@implementation SharePostationViewController

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
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    self.view.frame = [UIView fitCGRect:CGRectMake(0, 0, 280, 150)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text  = @"分享我当前的位置";
    titleLab.frame = CGRectMake(0, 10, 280, 20);
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
    [titleLab release];
    
    UITextField *cntTxtFld = [[UITextField alloc]init];
    cntTxtFld.delegate = self;
    cntTxtFld.borderStyle = UITextBorderStyleLine;
    cntTxtFld.frame = CGRectMake(20, 30, 240, 30);
    [self.view addSubview:cntTxtFld];
    
    UILabel *curDstLab = [[UILabel alloc]init];
    curDstLab.text  = @"当前位置:深圳,西丽";
    curDstLab.frame = CGRectMake(20, 70, 280, 20);
    curDstLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:curDstLab];
    [curDstLab release];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [shareBtn setTitle:@"马上分享"
              forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(90, 100, 100, 30);
    [shareBtn addTarget:self
                 action:@selector(doButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInt:NOTICE_POSTATION_SHAREING],
                             NOTICE_TYPE,nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                        object:nil
                                                      userInfo:infoDic];
}
@end
