//
//  DstPointCell.m
//  CarHelp
//
//  Created by lynn on 13-7-4.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "DstPointCell.h"

@implementation DstPointCell
@synthesize dstLab;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        reSearchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        reSearchBtn.frame = CGRectMake(0, 0, frame.size.width/4, frame.size.height);
        [reSearchBtn setTitle:@"RS"
                     forState:UIControlStateNormal];
        [reSearchBtn addTarget:self
                        action:@selector(doButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reSearchBtn];
        
        dstLab = [[UILabel alloc]init];
        dstLab.textAlignment = NSTextAlignmentCenter;
        dstLab.frame = CGRectMake(frame.size.width/4, 0, frame.size.width/2, frame.size.height);
        dstLab.backgroundColor = [UIColor clearColor];
        [self addSubview:dstLab];
        
        beginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        beginBtn.frame = CGRectMake(frame.size.width*3/4, 0, frame.size.width/4, frame.size.height);
        [beginBtn setTitle:@"BG"
                  forState:UIControlStateNormal];
        [beginBtn addTarget:self
                     action:@selector(doButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:beginBtn];
    }
    return self;
}

- (void) dealloc
{
    [dstLab release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(CellView:ClickedIndex:)])
        {
            [delegate CellView:self
                  ClickedIndex:button.tag];
        }
    }
}
@end
