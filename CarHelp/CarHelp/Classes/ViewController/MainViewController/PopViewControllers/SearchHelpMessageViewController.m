//
//  SearchHelpMessageViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-5.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "SearchHelpMessageViewController.h"

@interface SearchHelpMessageViewController ()
@end

@implementation SearchHelpMessageViewController
@synthesize titleStr;
@synthesize helpType;

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
}

- (void) dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    //设置主题
    switch (helpType)
    {
        case HELP_ON_KEY:
        {
            titleStr = @"一键求助";
            break;
        }
        case HELP_STOP_CAR:
        {
            titleStr = @"泊车";
            break;
        }
        case HELP_WATER:
        {
            titleStr = @"加水";
            break;
        }
        case HELP_TRAUMA_DRESS:
        {
            titleStr = @"外伤包扎";
            break;
        }
        case HELP_CASUALTY_SALVATION:
        {
            titleStr = @"伤亡救助";
            break;
        }
        case HELP_TYRE:
        {
            titleStr = @"补胎";
            break;
        }
        case HELP_OIL_FEED:
        {
            titleStr = @"给油";
            break;
        }
        case HELP_OVER_CURRENT:
        {
            titleStr = @"过电";
            break;
        }
        default:
            break;
    }
    
    self.view.frame = [UIView fitCGRect:CGRectMake(0, 0, 280, 300)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = titleStr;
    titleLab.frame= CGRectMake(20, 20, 280, 20);
    titleLab.font = [UIFont systemFontOfSize:20];
    titleLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleLab];
    [titleLab release];
    
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 57, 236, 100)];
    tv.backgroundColor = [UIColor redColor];
    [self.view addSubview:tv];
    
//    UIExpandingTextView *contentTxtView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(20, 57, 236, 30)];
//    contentTxtView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(4.0f, 0.0f, 10.0f, 0.0f);
//    contentTxtView.delegate = self;
//    contentTxtView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:contentTxtView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.tag = 0;
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn addTarget:self
                 action:@selector(doButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setFrame:[UIView fitCGRect:CGRectMake(230, 20, 30, 30)]];
    [self.view addSubview:closeBtn];
    
    UIButton *dirBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dirBtn.tag = 1;
    [dirBtn setTitle:@"方向"
            forState:UIControlStateNormal];
    [dirBtn addTarget:self
               action:@selector(doButtonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [dirBtn setFrame:[UIView fitCGRect:CGRectMake(30, 200, 40, 30)]];
    [self.view addSubview:dirBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    photoBtn.tag = 2;
    [photoBtn setTitle:@"拍照"
            forState:UIControlStateNormal];
    [photoBtn addTarget:self
               action:@selector(doButtonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [photoBtn setFrame:[UIView fitCGRect:CGRectMake(80, 200, 40, 30)]];
    [self.view addSubview:photoBtn];
    
    UIButton *micBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    micBtn.tag = 3;
    [micBtn setTitle:@"录音"
              forState:UIControlStateNormal];
    [micBtn addTarget:self
                 action:@selector(doButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [micBtn setFrame:[UIView fitCGRect:CGRectMake(130, 200, 40, 30)]];
    [self.view addSubview:micBtn];
    
    UIButton *holdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    holdBtn.tag = 4;
    [holdBtn setTitle:@"稍后"
             forState:UIControlStateNormal];
    [holdBtn addTarget:self
                action:@selector(doButtonClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [holdBtn setFrame:[UIView fitCGRect:CGRectMake(30, 240, 100, 30)]];
    [self.view addSubview:holdBtn];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendBtn.tag = 5;
    [sendBtn setFrame:[UIView fitCGRect:CGRectMake(150, 240, 100, 30)]];
    [sendBtn setTitle:@"发起求助"
             forState:UIControlStateNormal];
    [sendBtn addTarget:self
                action:@selector(doButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag)
    {
        case 0:     //关闭
        {
            NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:NOTICE_CLOSE],NOTICE_TYPE, nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                object:nil
                                                              userInfo:infoDic];
            break;
        }
        case 1:     //方向
        {
            break;
        }
        case 2:     //拍照
        {   
            break;
        }
        case 3:     //录音
        {
            break;
        }
        case 4:     //稍后
        {
            NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:NOTICE_HOLD_ON],
                                                                               NOTICE_TYPE, nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                object:nil
                                                              userInfo:infoDic];
            break;
        }
        case 5:     //发起求助
        {
            NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithInt:NOTICE_SEND_MSG], NOTICE_TYPE,
                                     [NSNumber numberWithInt:helpType], HELP_TYPE,
                                     titleStr,@"HELP_CONTENT", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                object:nil
                                                              userInfo:infoDic];
            break;
        }
        default:
            break;
    }
}
@end
