//
//  HelpFriendCell.h
//  CarHelp
//
//  Created by lynn on 13-7-8.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelpFriendCell;
@protocol HelpFriendCellDelegate <NSObject>

- (void) helpFriendCell:(HelpFriendCell *)cell index:(int) index;

@end

@interface HelpFriendCell : UIView
{
    UIButton *headBtn;
    UILabel *nameLab;
    UILabel *pagLab;
    UILabel *drvExpLab;
    UILabel *skillLab;
    UILabel *recommendLab;
}
@property (nonatomic, retain) NSMutableDictionary *idDic;
@property (nonatomic, assign) id<HelpFriendCellDelegate> delegate;
@end
