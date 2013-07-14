//
//  HelpContentViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-8.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpContentViewController.h"

@interface HelpContentViewController ()

@end

@implementation HelpContentViewController

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
    self.view.frame = [UIView fitCGRect:CGRectMake(0, 0, 250, 160)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateNow = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.tag = 0;
    [closeBtn setTitle:@"X"
              forState:UIControlStateNormal];
    [closeBtn addTarget:self
                 action:@selector(doButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = [UIView fitCGRect:CGRectMake(self.view.frame.size.width-40, 10, 30, 30)];
    [self.view addSubview:closeBtn];
    
    timeLab = [[UILabel alloc]init];
    timeLab.text = dateNow;
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.frame = [UIView fitCGRect:CGRectMake(0, 30, self.view.frame.size.width, 20)];
    [self.view addSubview:timeLab];
    
    contentLab = [[UILabel alloc]init];
    contentLab.text = @"我的车没油了!";
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.backgroundColor = [UIColor clearColor];
    contentLab.frame = [UIView fitCGRect:CGRectMake(0, 55, self.view.frame.size.width, 20)];
    [self.view addSubview:contentLab];
    
    imageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    imageBtn.frame = [UIView fitCGRect:CGRectMake(self.view.frame.size.width/2-50, 80, 40, 40)];
    [imageBtn setTitle:@"图片"
              forState:UIControlStateNormal];
    [self.view addSubview:imageBtn];
    
    voiceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    voiceBtn.frame = [UIView fitCGRect:CGRectMake(self.view.frame.size.width/2+10, 80, 40, 40)];
    [voiceBtn setTitle:@"声音"
              forState:UIControlStateNormal];
    [self.view addSubview:voiceBtn];
}

- (void) dealloc
{
    [timeLab release];
    [contentLab release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag)
    {
        case 0:
        {
            NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:NOTICE_CLOSE],NOTICE_TYPE, nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                object:nil
                                                              userInfo:infoDic];
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        default:
            break;
    }
}
@end
