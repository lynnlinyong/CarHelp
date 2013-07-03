//
//  DstCalloutAnnotationView.h
//  CarHelp
//
//  Created by lynn on 13-7-4.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "BMKAnnotationView.h"
@interface DstCalloutAnnotationView : BMKAnnotationView
@property (nonatomic, retain) UIView       *contentView;
@property (nonatomic, retain) DstPointCell *dstPointCell;
@end
