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
	self.tableData = [NSArray arrayWithObjects:@"Cracow",@"Sucha Beskidzka",@"Bielsko-Biala",@"Bialystok",@"Bydgoszcz",@"Czestochowa",@"Elblag",@"Gdansk",@"Gdynia",@"Gliwice",@"Gorzow Wielkopolski",@"Grudziadz",@"Kalisz",@"Katowice",@"Kielce",@"Koszalin",@"Legnica",@"Lublin",@"Olsztyn",@"Opole",@"Radom",@"Plock",@"Rzeszow",@"Sosnowiec",@"Warszawa",@"Wroclaw",@"Torun",@"Tarnow",@"Cracow",@"Sucha Beskidzka",@"Bielsko-Biala",@"Bialystok",@"Bydgoszcz",@"Czestochowa",@"Elblag",@"Gdansk",@"Gdynia",@"Gliwice",@"Gorzow Wielkopolski",@"Grudziadz",@"Kalisz",@"Katowice",@"Kielce",@"Koszalin",@"Legnica",@"Lublin",@"Olsztyn",@"Opole",@"Radom",@"Plock",@"Rzeszow",@"Sosnowiec",@"Warszawa",@"Wroclaw",@"Torun",@"Tarnow", nil];
	
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
