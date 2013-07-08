//
//  HelpSearchViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-5.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpSearchViewController.h"

@interface HelpSearchViewController ()

@end

@implementation HelpSearchViewController

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
                    cell.label.text = @"扫描求助";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"组团出游";
                    break;
                }
                case 2:
                {
                    cell.label.text = @"位置分享";
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
                    cell.label.text = @"导引";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"隐身";
                    break;
                }
                case 2:
                {
                    cell.label.text = @"勿扰模式";
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
                    cell.label.text = @"对话";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"好友列表";
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
                case 0:         //扫描求助
                {
                    break;
                }
                case 1:         //助团出游
                {
                    break;
                }
                case 2:         //位置分享
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
                case 0:         //导引
                {
                    break;
                }
                case 1:         //隐身
                {
                    break;
                }
                case 2:         //勿扰模式
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
                case 0:         //对话
                {
                    break;
                }
                case 1:         //好友列表
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
