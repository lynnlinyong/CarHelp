//
//  HelpFriendTableViewCell.h
//  CarHelp
//
//  Created by lynn on 13-7-9.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelpFriendTableViewCell;
@protocol HelpFriendTableViewCellDelegate <NSObject>

- (void) tableViewCell:(HelpFriendTableViewCell *) cell index:(int) index;

@end

@interface HelpFriendTableViewCell : UITableViewCell
@property (nonatomic, retain) UIButton  *headBtn;
@property (nonatomic, retain) UILabel   *nameLab;
@property (nonatomic, retain) UIButton  *okBtn;
@property (nonatomic, assign) id<HelpFriendTableViewCellDelegate> delegate;
@end
