//
//  FriendsViewController.m
//  CarHelp
//
//  Created by lynn on 13-6-21.
//  Copyright (c) 2013年 lynn. All rights reserved.
//
#import "ShareData.h"
#import "FriendsViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload
{
    searchBar.delegate = nil;
    
    frdTab.delegate = nil;
    frdTab.dataSource = nil;
    
    searchDisplay.delegate = nil;
    searchDisplay.searchResultsDelegate = nil;
    searchDisplay.searchResultsDataSource = nil;
    [super viewDidUnload];
}

- (void) dealloc
{
    [frdTab release];
    frdTab = nil;
    
    [searchBar release];
    searchBar = nil;
    
    [searchDisplay release];
    searchDisplay = nil;
    
    [frdArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Custom Action
- (void) initUI
{
    self.title = @"我的助友";
    
    frdArray = [[NSMutableArray alloc]init];
    
    Friend *frd   = [[Friend alloc]init];
    frd.userName  = @"张三";
    frd.accountId = @"1234567";
    frd.goodSkills= @"加水";
    frd.helpCount = 1;
    frd.isFastFrd = NO;
    frd.head  = @"boy_1";
    frd.score = 500;
    frd.honre = 10;
    frd.packagePercent = 0.3;
    [frdArray addObject:frd];
    
    Friend *frd1   = [[Friend alloc]init];
    frd1.userName  = @"张三";
    frd1.accountId = @"1234567";
    frd1.goodSkills= @"加水";
    frd1.helpCount = 1;
    frd1.isFastFrd = NO;
    frd1.head  = @"boy_1";
    frd1.score = 500;
    frd1.honre = 10;
    frd1.packagePercent = 0.3;
    [frdArray addObject:frd1];
    
    searchArray = [[NSMutableArray alloc]init];
    
    searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    searchBar.frame = [UIView fitCGRect:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:searchBar];
    
    searchDisplay = [[UISearchDisplayController alloc]initWithSearchBar:searchBar
                                                     contentsController:self];
    searchDisplay.delegate = self;
    searchDisplay.searchResultsDataSource = self;
    searchDisplay.searchResultsDelegate   = self;

    frdTab = [[UITableView alloc]init];
    frdTab.frame = [UIView fitCGRect:CGRectMake(0, 44, 320, 420)];
    frdTab.delegate   = self;
    frdTab.dataSource = self;
    [self.view addSubview:frdTab];
}

- (void)filterContentForSearchText:(NSString*)searchText                               scope:(NSString*)scope {
    
    [searchArray removeAllObjects];
    
//    NSPredicate *resultPredicate = [NSPredicate                                      predicateWithFormat:@"SELF contains%@",                                     searchText];
    
    [searchArray addObject:[frdArray objectAtIndex:0]];
}

#pragma mark -
#pragma mark UISearchDisplayDelegate
// when we start/end showing the search UI
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{}
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{}

// called when the table is created destroyed, shown or hidden. configure as necessary.
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView{}

// called when table is shown/hidden
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView{}
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView{}
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView{}
- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView{}

// return YES to reload table. called when search string/option changes. convenience methods on top UISearchBar delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    NSInteger index  = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    NSArray *buttons = [self.searchDisplayController.searchBar scopeButtonTitles];
    NSString *scope  = [buttons objectAtIndex:index];
    [self filterContentForSearchText:searchString
                               scope:scope];
    
    return NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    NSArray *buttons = [self.searchDisplayController.searchBar scopeButtonTitles];
    NSString *scope = [buttons objectAtIndex:searchOption];
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text
                               scope:scope];
    
    return NO;
}

#pragma mark -
#pragma mark - UITableViewDelegate and UITableDatasource
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return searchArray.count;
    }
    return frdArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *frd = nil;
    NSString *idString    = @"idString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:idString];
    }
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        frd = [searchArray objectAtIndex:indexPath.row];
    }
    else
    {
        frd = [frdArray objectAtIndex:indexPath.row];
    }
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.tag = indexPath.row;
    [headBtn setImage:[UIImage imageNamed:frd.head]
             forState:UIControlStateNormal];
    [headBtn setFrame:CGRectMake(5, 2, 40, 40)];
    [headBtn addTarget:self
                action:@selector(doHeadDetailAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:headBtn];
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text  = frd.userName;
    nameLab.frame = CGRectMake(50, cell.frame.size.height/2-10, 200, 20);
    [cell addSubview:nameLab];
    [nameLab release];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - UIButton Clicked Action
- (void)doHeadDetailAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    Friend *frd = [frdArray objectAtIndex:btn.tag];
    FriendDetailViewController *fVc = [[FriendDetailViewController alloc]init];
    fVc.frd = frd;
    [self.navigationController pushViewController:fVc
                                         animated:YES];
    [fVc release];
}
@end
