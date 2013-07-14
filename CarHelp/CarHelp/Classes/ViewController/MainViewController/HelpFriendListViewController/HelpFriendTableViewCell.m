//
//  HelpFriendTableViewCell.m
//  CarHelp
//
//  Created by lynn on 13-7-9.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpFriendTableViewCell.h"

@implementation HelpFriendTableViewCell
@synthesize okBtn;
@synthesize headBtn;
@synthesize nameLab;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.tag = 0;
        headBtn.frame = CGRectMake(5, 2, 40, 40);
        [headBtn addTarget:self
                    action:@selector(doButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headBtn];
        
        nameLab = [[UILabel alloc]init];
        nameLab.backgroundColor = [UIColor clearColor];
        nameLab.frame = CGRectMake(50, 4, 180, 20);
        [self addSubview:nameLab];
        
        okBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        okBtn.tag = 1;
        [okBtn setTitle:@"OK"
               forState:UIControlStateNormal];
        [okBtn addTarget:self
                  action:@selector(doButtonClicked:)
        forControlEvents:UIControlEventTouchUpInside];
        okBtn.frame = CGRectMake(320-90, 2, 80, 40);
        [self addSubview:okBtn];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) dealloc
{
    [nameLab release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(tableViewCell:index:)])
        {
            [delegate tableViewCell:self index:button.tag];
        }
    }
}
@end
