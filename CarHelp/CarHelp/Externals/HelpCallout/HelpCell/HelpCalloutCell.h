//
//  HelpCell.h
//  CarHelp
//
//  Created by lynn on 13-7-7.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelpCalloutCell;
@protocol HelpCalloutCellDelegate <NSObject>

- (void) helpCallOutCell:(HelpCalloutCell *)cell ClickedIndex:(int) index;

@end

@interface HelpCalloutCell : UIView
{
    UIButton    *reStartBtn;
    UIButton    *cancelBtn;
    UIButton    *detailBtn;
}
@property (nonatomic, retain) NSMutableDictionary *idDic;
@property (nonatomic, assign) id<HelpCalloutCellDelegate> delegate;
@end
