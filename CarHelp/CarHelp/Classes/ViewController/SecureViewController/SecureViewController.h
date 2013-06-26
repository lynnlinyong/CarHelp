//
//  SecureViewController.h
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecureViewController : UIViewController<UITextFieldDelegate>
{
}
@property (nonatomic, retain) UITextField *accountFld;
@property (nonatomic, retain) UITextField *pwdFld;
@end
