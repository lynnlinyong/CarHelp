//
//  PackageDetalViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-24.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "PackageDetalViewController.h"

@interface PackageDetalViewController ()

@end

@implementation PackageDetalViewController

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
    self.title = @"医药包";
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    UIBarButtonItem *rightBItem = [[UIBarButtonItem alloc]initWithTitle:@"添加"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(doAddClicked:)];
    self.navigationItem.rightBarButtonItem = rightBItem;
    [rightBItem release];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void) doAddClicked:(id)sender
{
    PackageMineViewController *pmVc = [[PackageMineViewController alloc]init];
    [self.navigationController pushViewController:pmVc animated:YES];
    [pmVc release];
}
@end
