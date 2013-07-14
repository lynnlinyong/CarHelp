//
//  TeamTableViewCell.h
//  CarHelp
//
//  Created by lynn on 13-7-14.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeamTableViewCell;
@protocol TeamTableViewCellDelegate <NSObject>

- (void) tableViewCell:(TeamTableViewCell *)cell index:(int) buttonIndex;

@end

@interface TeamTableViewCell : UITableViewCell
{
    UIButton *headBtn;
    UILabel  *teamNameLab;
    UILabel  *teamDescripteLab;
    UILabel  *teamMembersLab;
    
    Team     *team;
}

@property (nonatomic, retain) Team  *team;
@property (nonatomic, assign) id<TeamTableViewCellDelegate> delegate;
@end
