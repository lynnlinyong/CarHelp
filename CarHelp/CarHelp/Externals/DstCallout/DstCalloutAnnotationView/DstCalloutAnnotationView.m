//
//  DstCalloutAnnotationView.m
//  CarHelp
//
//  Created by lynn on 13-7-4.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "DstCalloutAnnotationView.h"

#define Arror_height 6

@implementation DstCalloutAnnotationView
@synthesize contentView;
@synthesize dstPointCell;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)initWithAnnotation:(id<BMKAnnotation>)annotation
        reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout  = NO;
        self.centerOffset    = CGPointMake(0, -55);
        self.frame = CGRectMake(0, 0, 240, 60);
        UIView *_contentView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-15)];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        self.contentView = _contentView;
        [_contentView release];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

-(void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    CGFloat maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect); 
    CGFloat maxy = CGRectGetMaxY(rrect)-Arror_height;
    
    CGContextMoveToPoint(context, midx+Arror_height, maxy);
    CGContextAddLineToPoint(context,midx, maxy+Arror_height);
    CGContextAddLineToPoint(context,midx-Arror_height, maxy);
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}
@end
