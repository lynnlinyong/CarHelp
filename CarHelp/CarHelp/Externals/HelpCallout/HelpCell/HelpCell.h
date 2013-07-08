//
//  HelpCell.h
//  CarHelp
//
//  Created by lynn on 13-7-7.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelpCell;
@protocol HelpCellDelegate <NSObject>

- (void) helpCell:(HelpCell *)cell ClickedIndex:(int) index;

@end

@interface HelpCell : UIView
{
    UIButton    *reStartBtn;
    UIButton    *cancelBtn;
    UIButton    *detailBtn;
}
@property (nonatomic, assign) id<HelpCellDelegate> delegate;
@end
