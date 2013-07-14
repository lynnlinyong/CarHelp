//
//  TeamTableViewCell.m
//  CarHelp
//
//  Created by lynn on 13-7-14.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "TeamTableViewCell.h"

@implementation TeamTableViewCell
@synthesize team;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.tag = 0;
        headBtn.frame = CGRectMake(10, 2, 40, 40);
        [headBtn addTarget:self
                    action:@selector(doButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headBtn];
        
        teamNameLab = [[UILabel alloc]init];
        teamNameLab.backgroundColor = [UIColor clearColor];
        teamNameLab.frame = CGRectMake(55, 2, 200, 20);
        [self addSubview:teamNameLab];
        
        teamDescripteLab = [[UILabel alloc]init];
        teamDescripteLab.backgroundColor = [UIColor clearColor];
        teamDescripteLab.frame = CGRectMake(55, 22, 200, 20);
        [self addSubview:teamDescripteLab];
        
        teamMembersLab = [[UILabel alloc]init];
        teamMembersLab.backgroundColor = [UIColor clearColor];
        teamMembersLab.textAlignment = NSTextAlignmentRight;
        teamMembersLab.frame = CGRectMake(320-110, 2, 100, 20);
        [self addSubview:teamMembersLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) dealloc
{
    [team release];
    [teamNameLab release];
    [teamMembersLab release];
    [teamDescripteLab release];
    [super dealloc];
}

- (void) setTeam:(Team *)tmpTeam
{
    team = [tmpTeam copy];
    
    [headBtn setImage:[UIImage imageNamed:team.teamIcon]
             forState:UIControlStateNormal];
    teamNameLab.text = team.teamName;
    teamDescripteLab.text = team.teamDescripte;
    teamMembersLab.text = @"共4人";
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
