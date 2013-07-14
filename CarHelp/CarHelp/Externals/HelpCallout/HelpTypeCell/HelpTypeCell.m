//
//  HelpTypeCell.m
//  CarHelp
//
//  Created by lynn on 13-7-10.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpTypeCell.h"

#define WIDTH   30
#define HEIGHT  30

#define REFRENT_POINT_X   120
#define REFRENT_POINT_Y   110

@implementation HelpTypeCell
@synthesize idDic;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

- (void) setIdDic:(NSMutableDictionary *)dic
{
    NSMutableArray *helpArray = [dic objectForKey:@"HELP_ARRAY"];
    for (int i=0; i<helpArray.count; i++)
    {
        CGRect rect;
        rect.size.width  = 30;
        rect.size.height = 30;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        double PI = M_PI*(i+1)/(helpArray.count+1);
        rect.origin.y = REFRENT_POINT_Y+(REFRENT_POINT_Y-sinf(PI) * REFRENT_POINT_Y);
        rect.origin.x = REFRENT_POINT_X - cosf(PI) * REFRENT_POINT_Y;
        button.frame  = rect;
        button.center = rect.origin;
        [self addSubview:button];
    }
}

@end
