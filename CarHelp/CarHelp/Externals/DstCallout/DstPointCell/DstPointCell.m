//
//  DstPointCell.m
//  CarHelp
//
//  Created by lynn on 13-7-4.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "DstPointCell.h"

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
	CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end


@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@implementation DstPointCell
@synthesize dstLab;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        reSearchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        reSearchBtn.tag = 0;
        reSearchBtn.frame = CGRectMake(0, 0, frame.size.width/4, frame.size.height);
        [reSearchBtn setTitle:@"X"
                     forState:UIControlStateNormal];
        [reSearchBtn addTarget:self
                        action:@selector(doButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reSearchBtn];
        
        dstLab = [[UILabel alloc]init];
        dstLab.textAlignment = NSTextAlignmentCenter;
        dstLab.frame = CGRectMake(frame.size.width/4, 0, frame.size.width/2, frame.size.height);
        dstLab.backgroundColor = [UIColor clearColor];
        [self addSubview:dstLab];
        
        beginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        beginBtn.tag = 1;
        beginBtn.frame = CGRectMake(frame.size.width*3/4, 0, frame.size.width/4, frame.size.height);
        [beginBtn setTitle:@"->"
                  forState:UIControlStateNormal];
        [beginBtn addTarget:self
                     action:@selector(doButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:beginBtn];
    }
    return self;
}

- (void) dealloc
{
    [dstLab release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(CellView:ClickedIndex:)])
        {
            [delegate CellView:self
                  ClickedIndex:button.tag];
        }
    }
}
@end
