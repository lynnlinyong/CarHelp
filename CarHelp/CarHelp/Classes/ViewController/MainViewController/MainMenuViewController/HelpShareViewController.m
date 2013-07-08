//
//  HelpShareViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-5.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpShareViewController.h"

@interface HelpShareViewController ()

@end

@implementation HelpShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = [UIView fitCGRect:CGRectMake(0, 0, 280, 300)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    gridView = [[UIGridView alloc]initWithFrame:CGRectMake(0, 5, 280, 300)];
    gridView.uiGridViewDelegate = self;
    [self.view addSubview:gridView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidUnload
{
    gridView.uiGridViewDelegate = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [gridView release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UIGridViewDelegate

- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
	return 100;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
	return 100;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
	return 3;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
	return 8;
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	Cell *cell = (Cell *)[grid dequeueReusableCell];
	
	if (cell == nil) {
		cell = [[Cell alloc] init];
	}
    
    switch (rowIndex)
    {
        case 0:
        {
            switch (columnIndex)
            {
                case 0:
                {
                    cell.label.text = @"堵车";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"事故";
                    break;
                }
                case 2:
                {
                    cell.label.text = @"危险";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (columnIndex)
            {
                case 0:
                {
                    cell.label.text = @"摄像头";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"地图聊天";
                    break;
                }
                case 2:
                {
                    cell.label.text = @"修路";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            switch (columnIndex)
            {
                case 0:
                {
                    cell.label.text = @"此路不通";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"开启乘车安全";
                    break;
                }
                case 2:
                {
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
	
	return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
	switch (rowIndex)
    {
        case 0:
        {
            switch (colIndex)
            {
                case 0:         //堵车
                {
                    break;
                }
                case 1:         //事故
                {
                    break;
                }
                case 2:         //危险
                {
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (colIndex)
            {
                case 0:         //摄像头
                {
                    break;
                }
                case 1:         //地图聊天
                {
                    break;
                }
                case 2:         //修路
                {
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            switch (colIndex)
            {
                case 0:         //此路不通
                {
                    break;
                }
                case 1:         //安全乘车安全
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

@end
