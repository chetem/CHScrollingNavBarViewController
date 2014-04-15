//
//  CHExampleViewController.m
//  ScrollingNavBar
//
//  Created by Chris Hetem on 4/14/14.
//  Copyright (c) 2014 croberth. All rights reserved.
//

#import "CHExampleViewController.h"

@interface CHExampleViewController ()

@property (nonatomic, strong) NSArray *tableData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CHExampleViewController

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
    // Do any additional setup after loading the view.
	self.tableData = [NSArray arrayWithObjects:@"Impanation", @"martyrological", @"eath", @"unfussiness", @"unstretched", @"mtis", @"submental", @"protestor", @"pseudocentric", @"peacemaker", @"diesel", @"jovial", @"mentone", @"diamant", @"outgrin", @"tenn", @"seorita", @"militating", @"counterrotating", @"unpartaken", @"nonsocialistic", @"vagabond", @"topfull", @"hucar", @"ahithophel", @"tenotomy", @"skeptic", @"quit", @"uncounseled", @"attlee", @"grosswardein", @"treelessness", @"uppermost", @"leucocythemic", @"henslowe", @"grit", @"climatical", @"physicochemical", @"occident", @"iolanthe", @"reperceived", @"counterattractively", @"gwari", @"nonrestitution", @"suffusion", @"brasilein", @"quandong", @"petulancy", @"yingkow", @"behmen", @"toxiphobia", @"sudetenland", @"infectiousness", @"restyle", @"condimentary", @"personalistic", @"gasmetophytic", @"fieldstone", @"healthiness", @"pathogen", @"landsting", @"calaboose", @"mountainside", @"genocidal", @"escribe", @"omnifarious", @"underpopulation", @"curstly", @"olefine", @"jogjakarta", nil];
	
	self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
	self.title = @"Scroll Test";
	
	[self initNavBarScrollingForScrollView:self.tableView];
	[self setAnimationDuration:0.2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	[self startNavBarScrolling:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self followScrollViewScrolling:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[self endScrollViewScrolling:scrollView willDecelerate:decelerate];
}



@end
