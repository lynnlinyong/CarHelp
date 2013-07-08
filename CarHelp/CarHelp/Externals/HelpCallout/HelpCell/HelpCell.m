//
//  HelpCell.m
//  CarHelp
//
//  Created by lynn on 13-7-7.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpCell.h"

@implementation HelpCell
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        reStartBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        reStartBtn.tag = 0;
        reStartBtn.frame = CGRectMake(0, 0, frame.size.width/4, frame.size.height);
        [reStartBtn setTitle:@"X"
                    forState:UIControlStateNormal];
        [reStartBtn addTarget:self
                       action:@selector(doButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reStartBtn];
        
        detailBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        detailBtn.tag = 1;
        detailBtn.frame = CGRectMake(frame.size.width/4, 0, frame.size.width/2, frame.size.height);
        [detailBtn setTitle:@"Detail"
                   forState:UIControlStateNormal];
        [detailBtn addTarget:self
                      action:@selector(doButtonClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:detailBtn];
        
        cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.tag = 2;
        cancelBtn.frame = CGRectMake(frame.size.width*3/4, 0, frame.size.width/4, frame.size.height);
        [cancelBtn setTitle:@"->"
                   forState:UIControlStateNormal];
        [cancelBtn addTarget:self
                      action:@selector(doButtonClicked:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
    }
    return self;
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
            [delegate helpCell:self ClickedIndex:button.tag];
        }
    }
}
@end
