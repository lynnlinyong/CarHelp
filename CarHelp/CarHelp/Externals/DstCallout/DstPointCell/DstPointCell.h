//
//  DstPointCell.h
//  CarHelp
//
//  Created by lynn on 13-7-4.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DstPointCell;
@protocol DstPointCellDelegate <NSObject>

- (void) CellView:(DstPointCell *)cell ClickedIndex:(int) index;

@end

@interface DstPointCell : UIView
{
    UILabel     *dstLab;
    UIButton    *beginBtn;
    UIButton    *reSearchBtn;
}

@property (nonatomic, retain) UILabel   *dstLab;
@property (nonatomic, assign) id<DstPointCellDelegate> delegate;
@end
