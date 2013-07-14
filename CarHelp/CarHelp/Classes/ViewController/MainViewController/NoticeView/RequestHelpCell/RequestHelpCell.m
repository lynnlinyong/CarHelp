//
//  RquestHelp.m
//  CarHelp
//
//  Created by lynn on 13-7-9.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "RequestHelpCell.h"

@implementation RequestHelpCell
@synthesize okBtn;
@synthesize idDic;
@synthesize circularTimer;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        groupView = [[LBorderView alloc]initWithFrame:CGRectMake(10, 5, 300, 45)];
        groupView.borderType   = BorderTypeDashed;
        groupView.dashPattern  = 8;
        groupView.spacePattern = 8;
        groupView.borderWidth  = 2;
        groupView.cornerRadius = 20;
        groupView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:groupView];
        
        headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.tag = 0;
        headBtn.frame = CGRectMake(5, 2.5, 40, 40);
        [headBtn addTarget:self
                    action:@selector(doButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        [groupView addSubview:headBtn];
        
        nameLab = [[UILabel alloc]init];
        nameLab.frame = CGRectMake(65, 12.5, 200, 20);
        nameLab.backgroundColor = [UIColor clearColor];
        [groupView addSubview:nameLab];
        
        okBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        okBtn.tag = 1;
        okBtn.frame = CGRectMake(300-50, 7, 30, 30);
        [okBtn setTitle:@"="
               forState:UIControlStateNormal];
        [okBtn addTarget:self
                  action:@selector(doButtonClicked:)
        forControlEvents:UIControlEventTouchUpInside];
        [groupView addSubview:okBtn];
        
        //显示倒计时时间
        [self showCircularTime];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) dealloc
{
    [idDic release];
    [nameLab release];
    [groupView     release];
    [circularTimer release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag)
    {
        case 0:             //助友详细资料
        {
            break;
        }
        case 1:             //请求助友帮助
        {
            [self showCircularTime];
            break;
        }
        default:
            break;
    }
}

- (void) showCircularTime
{
    NSDate *now = [NSDate date];
    NSTimeInterval timeInt = [now timeIntervalSince1970]+10;
    NSDate *finalDate = [NSDate dateWithTimeIntervalSince1970:timeInt];
    circularTimer = [[CircularTimer alloc] initWithPosition:CGPointMake(245, 2)
                                                     radius:20
                                             internalRadius:18
                                          circleStrokeColor:[UIColor whiteColor]
                                    activeCircleStrokeColor:[UIColor redColor]
                                                initialDate:now
                                                  finalDate:finalDate
                                              startCallback:^{
                                                  okBtn.enabled = NO;
                                              }
                                                endCallback:^{
                                                    okBtn.enabled = YES;
                                                    [circularTimer removeFromSuperview];
                                                    [circularTimer release];
                                                    circularTimer = nil;
                                                    
                                                    //恢复系统Normal状态消息
                                                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:NOTICE_REQUEST_FRIEND_HELP_END],
                                                                             NOTICE_TYPE,idDic, @"ID_DIC", nil];
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                                                        object:nil
                                                                                                      userInfo:infoDic];
                                                }];
    [groupView addSubview:circularTimer];
}

- (void) setIdDic:(NSMutableDictionary *)dic
{
    idDic = [dic mutableCopy];
    
    Friend *frd = [dic objectForKey:@"USER"];
    if (frd)
    {
        [headBtn setImage:[UIImage imageNamed:frd.head]
                 forState:UIControlStateNormal];
        
        nameLab.text = frd.userName;
    }
}

-(UIImageView*)deleteGreyImageView {
    if (!_deleteGreyImageView) {
        _deleteGreyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentView.frame), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
        [_deleteGreyImageView setImage:[UIImage imageNamed:@"DeleteGrey"]];
        [_deleteGreyImageView setContentMode:UIViewContentModeCenter];
        [self.backView addSubview:_deleteGreyImageView];
    }
    return _deleteGreyImageView;
}

-(UIImageView*)deleteRedImageView {
    if (!_deleteRedImageView) {
        _deleteRedImageView = [[UIImageView alloc] initWithFrame:self.deleteGreyImageView.bounds];
        [_deleteRedImageView setImage:[UIImage imageNamed:@"DeleteRed"]];
        [_deleteRedImageView setContentMode:UIViewContentModeCenter];
        [self.deleteGreyImageView addSubview:_deleteRedImageView];
    }
    return _deleteRedImageView;
}

-(void)prepareForReuse {
	[super prepareForReuse];
	self.textLabel.textColor = [UIColor blackColor];
	self.detailTextLabel.text = nil;
	self.detailTextLabel.textColor = [UIColor grayColor];
	[self setUserInteractionEnabled:YES];
	self.imageView.alpha = 1;
	self.accessoryView = nil;
	self.accessoryType = UITableViewCellAccessoryNone;
    [self.contentView setHidden:NO];
    //    [_checkmarkProfileImageView removeFromSuperview];
    //    _checkmarkProfileImageView = nil;
    [self cleanupBackView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.profileImageView.frame) + 10, CGRectGetMinY(self.textLabel.frame), CGRectGetWidth(self.textLabel.frame), CGRectGetHeight(self.textLabel.frame));
    //    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.profileImageView.frame) + 10, CGRectGetMinY(self.detailTextLabel.frame), CGRectGetWidth(self.detailTextLabel.frame), CGRectGetHeight(self.detailTextLabel.frame));
}

//-(void)setThumbnail:(UIImage*)image {
//	[self.profileImageView setImage:image];
//}

//-(void)setFavourite:(BOOL)favourite animated:(BOOL)animated {
//    self.isFavourite = favourite;
//    if (animated) {
//        if (favourite) {
//            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
//            animation.toValue = (id)[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor;
//            animation.fromValue = (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor;
//            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//            animation.duration = 0.25;
//            [self.profileImageView.layer addAnimation:animation forKey:@"animateBorderColor"];
//            [self.profileImageView.layer setBorderColor:[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor];
//            [self.checkmarkProfileImageView setAlpha:0];
//            [self.profileImageView addSubview:_checkmarkProfileImageView];
//            [UIView animateWithDuration:0.25
//                             animations:^{
//                                 [self.checkmarkProfileImageView setAlpha:1];
//                             }];
//        } else {
//            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
//            animation.toValue = (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor;
//            animation.fromValue = (id)[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor;
//            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//            animation.duration = 0.25;
//            [self.profileImageView.layer addAnimation:animation forKey:@"animateBorderColor"];
//            [self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
//            [UIView animateWithDuration:0.25
//                             animations:^{
//                                 [self.checkmarkProfileImageView setAlpha:0];
//                             }
//                             completion:^(BOOL finished) {
//                                 [_checkmarkProfileImageView removeFromSuperview];
//                             }];
//        }
//    } else {
//        if (favourite) {
//            [self.checkmarkProfileImageView setAlpha:1];
//            [self.profileImageView addSubview:_checkmarkProfileImageView];
//            [self.profileImageView.layer setBorderColor:[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor];
//        } else {
//            [self.checkmarkProfileImageView setAlpha:0];
//            [_checkmarkProfileImageView removeFromSuperview];
//            [self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
//        }
//    }
//}

-(void)animateContentViewForPoint:(CGPoint)point velocity:(CGPoint)velocity {
    [super animateContentViewForPoint:point velocity:velocity];
    if (point.x > 0) {
        // set the checkmark's frame to match the contentView
        //        [self.checkmarkGreyImageView setFrame:CGRectMake(MIN(CGRectGetMinX(self.contentView.frame) - CGRectGetWidth(self.checkmarkGreyImageView.frame), 0), CGRectGetMinY(self.checkmarkGreyImageView.frame), CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetHeight(self.checkmarkGreyImageView.frame))];
        //        if (point.x >= CGRectGetHeight(self.frame) && self.isFavourite == NO) {
        //            [self.checkmarkGreenImageView setAlpha:1];
        //        } else if (self.isFavourite == NO) {
        //            [self.checkmarkGreenImageView setAlpha:0];
        //        } else if (point.x >= CGRectGetHeight(self.frame) && self.isFavourite == YES) {
        //            // already a favourite; animate the green checkmark drop when swiped far enough for the action to kick in when user lets go
        //            if (self.checkmarkGreyImageView.alpha == 1) {
        //                [UIView animateWithDuration:0.25
        //                                 animations:^{
        //                                     CATransform3D rotate = CATransform3DMakeRotation(-0.4, 0, 0, 1);
        //                                     [self.checkmarkGreenImageView.layer setTransform:CATransform3DTranslate(rotate, -10, 20, 0)];
        //                                     [self.checkmarkGreenImageView setAlpha:0];
        //                                 }];
        //            }
        //        } else if (self.isFavourite == YES) {
        //            // already a favourite; but user panned back to a lower value than the action point
        //            CATransform3D rotate = CATransform3DMakeRotation(0, 0, 0, 1);
        //            [self.checkmarkGreenImageView.layer setTransform:CATransform3DTranslate(rotate, 0, 0, 0)];
        //            [self.checkmarkGreenImageView setAlpha:1];
        //        }
    } else if (point.x < 0) {
        // set the X's frame to match the contentView
        [self.deleteGreyImageView setFrame:CGRectMake(MAX(CGRectGetMaxX(self.frame) - CGRectGetWidth(self.deleteGreyImageView.frame), CGRectGetMaxX(self.contentView.frame)), CGRectGetMinY(self.deleteGreyImageView.frame), CGRectGetWidth(self.deleteGreyImageView.frame), CGRectGetHeight(self.deleteGreyImageView.frame))];
        if (-point.x >= CGRectGetHeight(self.frame)) {
            [self.deleteRedImageView setAlpha:1];
        } else {
            [self.deleteRedImageView setAlpha:0];
        }
    }
}

-(void)resetCellFromPoint:(CGPoint)point velocity:(CGPoint)velocity {
    [super resetCellFromPoint:point velocity:velocity];
    if (point.x > 0 && point.x <= CGRectGetHeight(self.frame)) {
        //        // user did not swipe far enough, animate the checkmark back with the contentView animation
        //        [UIView animateWithDuration:self.animationDuration
        //                         animations:^{
        //                             [self.checkmarkGreyImageView setFrame:CGRectMake(-CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetMinY(self.checkmarkGreyImageView.frame), CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetHeight(self.checkmarkGreyImageView.frame))];
        //                         }];
    } else if (point.x < 0) {
        if (-point.x <= CGRectGetHeight(self.frame)) {
            // user did not swipe far enough, animate the grey X back with the contentView animation
            [UIView animateWithDuration:self.animationDuration
                             animations:^{
                                 [self.deleteGreyImageView setFrame:CGRectMake(CGRectGetMaxX(self.frame), CGRectGetMinY(self.deleteGreyImageView.frame), CGRectGetWidth(self.deleteGreyImageView.frame), CGRectGetHeight(self.deleteGreyImageView.frame))];
                             }];
        } else {
            // user did swipe far enough to meet the delete action requirement, animate the Xs to show selection
            [UIView animateWithDuration:self.animationDuration
                             animations:^{
                                 [self.deleteGreyImageView.layer setTransform:CATransform3DMakeScale(2, 2, 2)];
                                 [self.deleteGreyImageView setAlpha:0];
                                 [self.deleteRedImageView.layer setTransform:CATransform3DMakeScale(2, 2, 2)];
                                 [self.deleteRedImageView setAlpha:0];
                             }];
        }
    }
}

-(void)cleanupBackView {
    [super cleanupBackView];
    //    [_checkmarkGreyImageView removeFromSuperview];
    //    _checkmarkGreyImageView = nil;
    //    [_checkmarkGreenImageView removeFromSuperview];
    //    _checkmarkGreenImageView = nil;
    [_deleteGreyImageView removeFromSuperview];
    _deleteGreyImageView = nil;
    [_deleteRedImageView removeFromSuperview];
    _deleteRedImageView = nil;
}

-(void) setBackGroupColor:(UIColor *)color
{
    self.backView.backgroundColor = color;
    self.contentView.backgroundColor = color;
    self.backgroundView.backgroundColor = color;
}

@end
