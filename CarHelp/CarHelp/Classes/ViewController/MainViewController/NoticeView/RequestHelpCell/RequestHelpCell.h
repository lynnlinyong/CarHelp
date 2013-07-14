//
//  RquestHelp.h
//  CarHelp
//
//  Created by lynn on 13-7-9.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "RMSwipeTableViewCell.h"

@interface RequestHelpCell : RMSwipeTableViewCell
{
    UIButton        *headBtn;
    UILabel         *nameLab;
    LBorderView     *groupView;
}
@property (nonatomic, retain) UIButton        *okBtn;
@property (nonatomic, retain) UIImageView  *deleteGreyImageView;
@property (nonatomic, retain) UIImageView  *deleteRedImageView;
@property (nonatomic, retain) CircularTimer   *circularTimer;
@property (nonatomic, retain) NSMutableDictionary *idDic;
- (void) setBackGroupColor:(UIColor *)color;
- (void) doButtonClicked:(id)sender;
@end
