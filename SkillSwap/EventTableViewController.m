//
//  EventTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/6/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventTableViewController.h"
#import <Parse/Parse.h>
#import "EventDetailViewController.h"
#import "EventResultsTableViewController.h"
#import "MLKMenuPopover.h"

#define MENU_POPOVER_FRAME  CGRectMake(fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.width)-130, 64, 120, 132)

@interface EventTableViewController() <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,MLKMenuPopoverDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) EventResultsTableViewController *resultsTableViewController;

@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

- (IBAction)showMoreOption:(id)sender;
@property(nonatomic,strong) MLKMenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;
@property(nonatomic,strong) NSMutableArray *menuIsSelected;


@end


@implementation EventTableViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query orderByAscending:@"eventDate"];
    self.events = [query findObjects];
    
    PFUser *currentUser = [PFUser currentUser];
    PFRelation *relation = [currentUser relationForKey:@"myEvent"];
    PFQuery *queryMyEvent = [relation query];
    [queryMyEvent selectKeys:nil];
    self.myEvents = [queryMyEvent findObjects];
    
    
    self.resultsTableViewController = [[EventResultsTableViewController alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableViewController];
    
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.resultsTableViewController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.barTintColor = [UIColor lightGrayColor];
    self.searchController.searchBar.tintColor = [UIColor colorWithRed:232/255.0 green:51/255.0 blue:102/255.0 alpha:1];
    self.definesPresentationContext = YES;
    
    CGPoint offset = CGPointMake(0, self.searchController.searchBar.frame.size.height);
    self.tableView.contentOffset = offset;
    
    self.menuItems = [NSArray arrayWithObjects:@"All Events", @"My Events", @"Pick for Me!", nil];
    self.menuIsSelected = [[NSMutableArray alloc] init];
    [self.menuIsSelected addObject:@"Y"];
    [self.menuIsSelected addObject:@"N"];
    [self.menuIsSelected addObject:@"N"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        self.searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            self.searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchControllerDelegate

- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (tableView == self.tableView) ? self.events.count : self.resultsTableViewController.filteredEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    PFObject *event = self.events[indexPath.row];
    BOOL isInMyEvent = false;

    for (PFObject *myEvent in self.myEvents) {
        if ([[myEvent objectId] isEqualToString:[event objectId]]) {
            isInMyEvent = true;
        }
            
    }
    [self configureCell:cell forPFObject:event withFlag:isInMyEvent];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *selectedEvent = (tableView == self.tableView) ?
    self.events[indexPath.row] : self.resultsTableViewController.filteredEvents[indexPath.row];
    
    EventDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    detailViewController.object = selectedEvent;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    
    PFQuery *query = [PFQuery queryWithClassName: @"Event"];
    [query whereKey:@"eventName" containsString:searchText];
    NSArray *searchResults  = [query findObjects];

    // hand over the filtered results to our search results table
    EventResultsTableViewController *tableViewController = (EventResultsTableViewController *)self.searchController.searchResultsController;
    tableViewController.tableView.rowHeight = 96.0;
    tableViewController.filteredEvents = searchResults;
    tableViewController.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableViewController.tableView reloadData];
}

#pragma mark - UIStateRestoration

// we restore several items for state restoration:
//  1) Search controller's active state,
//  2) search text,
//  3) first responder

NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}

#pragma mark -
#pragma mark Actions

- (IBAction)showMoreOption:(id)sender {
    // Hide already showing popover
    [self.menuPopover dismissMenuPopover];
    self.tableView.scrollEnabled = NO;
    [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
    self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems menuIsSelected:self.menuIsSelected];
    
    self.menuPopover.menuPopoverDelegate = self;
    [self.menuPopover showInView:self.view];
    self.menuPopover.tableView = self.tableView;
    


}

#pragma mark -
#pragma mark MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    [self.menuPopover dismissMenuPopover];
    switch (selectedIndex) {
        case 0: {
            self.menuIsSelected[0] = @"Y";
            self.menuIsSelected[1] = @"N";
            self.menuIsSelected[2] = @"N";
            PFQuery *query = [PFQuery queryWithClassName:@"Event"];
            [query orderByAscending:@"eventDate"];
            self.events = [query findObjects];
            [self.tableView reloadData];
            break;
        }
        case 1:{
            self.menuIsSelected[0] = @"N";
            self.menuIsSelected[1] = @"Y";
            self.menuIsSelected[2] = @"N";
            PFUser *currentUser = [PFUser currentUser];
            PFRelation *relation = [currentUser relationForKey:@"myEvent"];
            PFQuery *query = [relation query];
            [query orderByAscending:@"eventDate"];
            self.events = [query findObjects];
            self.myEvents = self.events;
            [self.tableView reloadData];
            break;
        }
            
        case 2:{
            self.menuIsSelected[0] = @"N";
            self.menuIsSelected[1] = @"N";
            self.menuIsSelected[2] = @"Y";
            break;
        }
        default:
            break;
    }
}

@end
