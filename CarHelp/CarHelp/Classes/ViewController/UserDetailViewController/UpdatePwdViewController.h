//
//  UpdatePwdViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-28.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePwdViewController : UIViewController <UITextFieldDelegate>
{
    UITextField  *oldPwdFld;
    UITextField  *newPwdFld;
    UITextField  *reNewPwdFld;
}


@end
