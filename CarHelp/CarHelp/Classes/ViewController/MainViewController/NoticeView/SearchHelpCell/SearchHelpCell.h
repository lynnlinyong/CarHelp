//
//  SearchHelpCell.h
//  CarHelp
//
//  Created by lynn on 13-7-8.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHelpCell : RMSwipeTableViewCell
{
    UILabel         *infoLab;
    UIImageView     *searchImgView;
    LBorderView     *groupView;
}
@property (nonatomic, retain) UIImageView  *deleteGreyImageView;
@property (nonatomic, retain) UIImageView  *deleteRedImageView;
@property (nonatomic, retain) NSDictionary *idDic;
- (void) setBackGroupColor:(UIColor *)color;
@end
