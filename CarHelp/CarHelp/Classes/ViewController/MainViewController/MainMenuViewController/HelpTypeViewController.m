//
//  HelpTypeViewController.m
//  CarHelp
//
//  Created by lynn on 13-7-5.
//  Copyright (c) 2013年 lynn. All rights reserved.
//

#import "HelpTypeViewController.h"

@interface HelpTypeViewController ()

@end

@implementation HelpTypeViewController

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
	return 9;
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
                    cell.label.text = @"一键求助";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"附近求助";
                    break;
                }
                case 2:
                {
                    cell.label.text = @"泊车";
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
                    cell.label.text = @"加水";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"外伤包扎";
                    break;
                }
                case 2:
                {
                    cell.label.text = @"伤亡求助";
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
                    cell.label.text = @"补胎";
                    break;
                }
                case 1:
                {
                    cell.label.text = @"给油";
                    break;
                }
                case 2:
                {
                    cell.label.text = @"过电";
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
                case 0:         //一键求助
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                         [NSNumber numberWithInt:NOTICE_HELP],
                                                                         NOTICE_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
                    break;
                }
                case 1:         //附近求助
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:NOTICE_NEARBY_HELP],
                                             NOTICE_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
                    break;
                }
                case 2:         //泊车
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:NOTICE_HELP_TYPE],
                                             NOTICE_TYPE,[NSNumber numberWithInt:HELP_STOP_CAR],
                                             HELP_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
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
                case 0:         //加水
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:NOTICE_HELP_TYPE],
                                             NOTICE_TYPE,[NSNumber numberWithInt:HELP_WATER],
                                             HELP_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
                    break;
                }
                case 1:         //外伤包扎
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:NOTICE_HELP_TYPE],
                                             NOTICE_TYPE,[NSNumber numberWithInt:HELP_TRAUMA_DRESS],
                                             HELP_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
                    break;
                }
                case 2:         //伤亡求助
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:NOTICE_HELP_TYPE],
                                             NOTICE_TYPE,[NSNumber numberWithInt:HELP_CASUALTY_SALVATION],
                                             HELP_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
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
                case 0:         //补胎
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:NOTICE_HELP_TYPE],
                                             NOTICE_TYPE,[NSNumber numberWithInt:HELP_TYRE],
                                             HELP_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
                    break;
                }
                case 1:         //给油
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:NOTICE_HELP_TYPE],
                                             NOTICE_TYPE,[NSNumber numberWithInt:HELP_OIL_FEED],
                                             HELP_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
                    break;
                }
                case 2:         //过电
                {
                    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithInt:NOTICE_HELP_TYPE],
                                             NOTICE_TYPE,[NSNumber numberWithInt:HELP_OVER_CURRENT],
                                             HELP_TYPE,nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MSG
                                                                        object:nil
                                                                      userInfo:infoDic];
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
}
@end
