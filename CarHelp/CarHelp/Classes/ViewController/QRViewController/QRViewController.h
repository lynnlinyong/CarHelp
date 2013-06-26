//
//  QRViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRViewController : UIViewController<
                                            UIAlertViewDelegate,
                                            ZBarReaderDelegate>
{
    
}

@property (nonatomic, retain) UIButton    *scanBtn;
@property (nonatomic, retain) UILabel     *resultLab;
@property (nonatomic, retain) UIImageView *scanCodeImgView;
@end
