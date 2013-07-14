//
//  DstNoticeViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-5.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "DstNoticeViewController.h"

@interface DstNoticeViewController ()

@end

@implementation DstNoticeViewController
@synthesize resultDic;
@synthesize delegate;

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

    self.view.frame = [UIView fitCGRect:CGRectMake(0, 0, 200, 180)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"准备出发";
    titleLab.font = [UIFont systemFontOfSize:20];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textAlignment = UITextAlignmentCenter;
    titleLab.frame = [UIView fitCGRect:CGRectMake(0, 5, 200, 20)];
    [self.view addSubview:titleLab];
    [titleLab release];

    NSNumber *disNum = [resultDic objectForKey:@"Distance"];
    NSDictionary *dstDic = [resultDic objectForKey:@"Distnation"];
    NSString *dst = [dstDic objectForKey:@"dstLoc"];
    
    UILabel *dstLab = [[UILabel alloc]init];
    dstLab.text = dst;
    dstLab.backgroundColor = [UIColor clearColor];
    dstLab.textAlignment = UITextAlignmentCenter;
    dstLab.frame = [UIView fitCGRect:CGRectMake(5, 60, 100, 20)];
    [self.view addSubview:dstLab];
    [dstLab release];
    
    UILabel *disLab = [[UILabel alloc]init];
    disLab.text = [NSString stringWithFormat:@"%.2f公里", [disNum intValue]/1000.0f];
    disLab.backgroundColor = [UIColor clearColor];
    disLab.textAlignment = UITextAlignmentCenter;
    disLab.frame = [UIView fitCGRect:CGRectMake(100, 60, 100, 20)];
    [self.view addSubview:disLab];
    [disLab release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"马上去"
            forState:UIControlStateNormal];
    [button setFrame:[UIView fitCGRect:CGRectMake(50, 120, 100, 30)]];
    [button addTarget:self
               action:@selector(doButtonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(viewController:sender:)])
        {
            [delegate viewController:self
                              sender:nil];
        }
    }
}
@end
