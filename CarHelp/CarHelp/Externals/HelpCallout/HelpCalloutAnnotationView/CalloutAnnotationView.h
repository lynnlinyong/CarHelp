//
//  HelpCalloutAnnotationView.h
//  CarHelp
//
//  Created by lynn on 13-7-7.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "BMKAnnotationView.h"

@interface CalloutAnnotationView : BMKAnnotationView
@property (nonatomic, retain) id callOutView;
@property (nonatomic, retain) UIView   *contentView;
@end
