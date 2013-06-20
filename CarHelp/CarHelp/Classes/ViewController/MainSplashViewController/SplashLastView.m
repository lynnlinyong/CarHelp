//
//  SplashLastView.m
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "SplashLastView.h"

@implementation SplashLastView
@synthesize spImgView;
@synthesize goMainBtn;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        spImgView   = [[UIImageView alloc]initWithFrame:[UIView fitCGRect:CGRectMake(320*3, 0, 320, 480)]];
        spImgView.backgroundColor = [UIColor greenColor];
        [self addSubview:spImgView];
        
        goMainBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [goMainBtn setFrame:[UIView fitCGRect:CGRectMake(110, 370, 100, 30)]];
        [goMainBtn setTitle:@"开始"
                   forState:UIControlStateNormal];
        [goMainBtn addTarget:self
                      action:@selector(doClickedAction:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goMainBtn];
    }
    return self;
}

- (void) dealloc
{
    [spImgView release];
    [super dealloc];
}

- (void) doClickedAction:(id)sender
{
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(splashView:doClicked:)])
        {
            [delegate splashView:self doClicked:sender];
        }
    }
}

@end
