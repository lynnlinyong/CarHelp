//
//  HelpCalloutAnnotationView.h
//  CarHelp
//
//  Created by lynn on 13-7-7.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "BMKAnnotationView.h"

@interface HelpCalloutAnnotationView : BMKAnnotationView
@property (nonatomic, retain) HelpCell *helpCell;
@property (nonatomic, retain) UIView   *contentView;
@end
