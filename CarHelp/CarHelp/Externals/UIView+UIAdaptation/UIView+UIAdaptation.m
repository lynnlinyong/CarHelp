//
//  UIView+UIAdaptation.m
//  DeviceShop
//
//  Created by lynn on 13-5-29.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "UIView+UIAdaptation.h"

@implementation UIView (UIAdaptation)

+ (float)currentSize:(BOOL)h
{
    CGRect screen_rect = [UIScreen getCurrentBounds];
    CGSize screen_size = screen_rect.size;
    
    //一般屏幕为1,Retina为2
    CGFloat screen_scale   = [[UIScreen mainScreen]scale];  
    float baseResolution_h = 480 * screen_scale;
    float baseResolution_w = 320 * screen_scale;
    
    float currentResolution_h;
    float currentResolution_w;

    //当前设备的分辨率
    currentResolution_h = screen_size.height * screen_scale;
    currentResolution_w = screen_size.width  * screen_scale;
    
    //高度与宽度分辨比例
    if (h)
    {
        return (float)currentResolution_h/baseResolution_h;
    }
    else
    {
        return (float)currentResolution_w/baseResolution_w;
    }
}

+ (CGRect)fitCGRect:(CGRect)rect
{
    float x = rect.origin.x;
    float y = rect.origin.y;
    float width  = rect.size.width;
    float height = rect.size.height;
    float currentSize_h = [self currentSize:YES];  //高度当前设备与480x320比例
    float currentSize_w = [self currentSize:NO];   //宽度当前设备与480x320比例
    
    CGRect frame = CGRectMake(x*currentSize_w, y*currentSize_h,
                              width*currentSize_w, height*currentSize_h);
    
    return frame;
}

@end
