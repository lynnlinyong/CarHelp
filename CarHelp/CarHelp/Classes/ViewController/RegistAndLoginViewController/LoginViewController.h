//
//  LoginViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-20.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
}

@property (nonatomic, retain) UITextField *userNameFld;
@property (nonatomic, retain) UITextField *pwdFld;
@end
