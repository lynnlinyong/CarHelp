//
//  DstPointCell.h
//  CarHelp
//
//  Created by lynn on 13-7-4.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘
	int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

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
