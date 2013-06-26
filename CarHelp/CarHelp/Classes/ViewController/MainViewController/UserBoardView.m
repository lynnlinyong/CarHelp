//
//  UserBoardView.m
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "UserBoardView.h"

@implementation UserBoardView
@synthesize delegate;

- (id) initWithFrame:(CGRect)frame withUser:(User *)user
{
    self = [super initWithFrame:frame];
    if (self) {
        headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.frame = CGRectMake(10, 10, 80, 80);
        [headBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", user.head]]
                 forState:UIControlStateNormal];
        [headBtn addTarget:self
                    action:@selector(doHeadBtnClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headBtn];
        
        unLab = [[UILabel alloc]init];
        unLab.frame = CGRectMake(90, 10, 200, 20);
        unLab.text  = user.userName;
        unLab.font  = [UIFont systemFontOfSize:20];
        [self addSubview:unLab];
        
        scoreLab = [[UILabel alloc]init];
        scoreLab.frame = CGRectMake(90, 40, 105, 20);
        scoreLab.text  = [NSString stringWithFormat:@"积分:%ld", user.score];
        [self addSubview:scoreLab];
        
        hcLab = [[UILabel alloc]init];
        hcLab.frame = CGRectMake(195, 40, 105, 20);
        hcLab.text  = [NSString stringWithFormat:@"施助数:%ld", user.helpCount];
        [self addSubview:hcLab];
        
        honorLab = [[UILabel alloc]init];
        honorLab.frame = CGRectMake(90, 70, 105, 20);
        honorLab.text  = [NSString stringWithFormat:@"荣誉:%ld", user.honre];
        [self addSubview:honorLab];
        
        activeLab = [[UILabel alloc]init];
        activeLab.frame = CGRectMake(195, 70, 105, 20);
        activeLab.text  = [NSString stringWithFormat:@"活跃度:达人"];
        [self addSubview:activeLab];
    }
    return self;
}

- (void) dealloc
{
    [unLab release];
    [hcLab release];
    [scoreLab    release];
    [honorLab    release];
    [activeLab   release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doHeadBtnClicked:(id) sender
{
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(userBoardView:headClicked:)])
        {
            [delegate userBoardView:self headClicked:headBtn];
        }
    }
}

@end
