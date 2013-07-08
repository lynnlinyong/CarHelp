//
//  HelpFriendCell.m
//  CarHelp
//
//  Created by lynn on 13-7-8.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpFriendCell.h"

@implementation HelpFriendCell
@synthesize idDic;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        closeBtn.tag = 0;
        [closeBtn setTitle:@"X" forState:UIControlStateNormal];
        closeBtn.frame = CGRectMake(frame.size.width-50, 5, 40, 40);
        [closeBtn addTarget:self
                     action:@selector(doButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.tag   = 1;
        headBtn.frame = CGRectMake(10, 5, 80, 80);
        [headBtn addTarget:self
                    action:@selector(doButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headBtn];
        
        nameLab = [[UILabel alloc]init];
        nameLab.backgroundColor = [UIColor clearColor];
        nameLab.frame = CGRectMake(100, 5, 100, 20);
        [self addSubview:nameLab];
        
        pagLab = [[UILabel alloc]init];
        pagLab.backgroundColor = [UIColor clearColor];
        pagLab.frame = CGRectMake(10, 90, frame.size.width-10, 20);
        [self addSubview:pagLab];
        
        recommendLab = [[UILabel alloc]init];
        recommendLab.frame = CGRectMake(10, 110, frame.size.width-10, 20);
        [self addSubview:recommendLab];
        
        drvExpLab = [[UILabel alloc]init];
        drvExpLab.frame = CGRectMake(10, 130, frame.size.width-10, 20);
        [self addSubview:drvExpLab];
        
        skillLab = [[UILabel alloc]init];
        skillLab.frame = CGRectMake(10, 150, frame.size.width-10, 20);
        [self addSubview:skillLab];
        
        UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        helpBtn.tag = 2;
        [helpBtn setTitle:@"请他帮助" forState:UIControlStateNormal];
        [helpBtn addTarget:self
                    action:@selector(doButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        helpBtn.frame = CGRectMake(frame.size.width/2-50, 170, 100, 20);
        [self addSubview:helpBtn];
    }
    return self;
}

- (void) dealloc
{
    [idDic release];
    
    [pagLab release];
    [nameLab release];
    [skillLab release];
    [drvExpLab release];
    [recommendLab release];
    [super dealloc];
}

- (void) setIdDic:(NSMutableDictionary *)dic
{
    idDic = [dic mutableCopy];
    
    Friend *frd = [dic objectForKey:@"USER"];
    if (frd)
    {
        nameLab.text = frd.userName;
        [headBtn setImage:[UIImage imageNamed:frd.head] forState:UIControlStateNormal];
        pagLab.text = [NSString stringWithFormat:@"装备完整度:%.2f", frd.packagePercent];
        recommendLab.text = [NSString stringWithFormat:@"系统推荐度:0.5"];
        drvExpLab.text = [NSString stringWithFormat:@"驾龄:8"];
        skillLab.text = [NSString stringWithFormat:@"特长:%@", frd.goodSkills];
    }
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id) sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag)
    {
        if (delegate)
        {
            if ([delegate respondsToSelector:@selector(helpFriendCell:index:)])
            {
                [delegate helpFriendCell:self index:button.tag];
            }
        }
    }
}
@end
