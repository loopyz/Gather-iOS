//
//  GatherInterestsViewController.m
//  Gather
//
//  Created by Lucy Guo on 7/10/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "GatherInterestsViewController.h"
#import <Parse/Parse.h>

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

@interface GatherInterestsViewController ()

@end

@implementation GatherInterestsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.bgColor = [UIColor colorWithRed:251/255.0f green:251/255.0f blue:251/255.0f alpha:1.0f];
        [self setupFriendsTable];
        [self changeBG];
    }
    return self;
}

- (void)setupFriendsTable
{
    CGRect tableViewRect = CGRectMake(10, 80, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 140);
    
    self.interestsTableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    self.interestsTableView.delegate = self;
    self.interestsTableView.dataSource = self;
    self.interestsTableView.backgroundColor = [UIColor clearColor];
    [self.interestsTableView setRowHeight:50];
    [self.interestsTableView setAllowsSelection:YES];
    [self.view addSubview:self.interestsTableView];
    
}

// temporarily set to friends in fb who also use the app
- (void) getFriends
{
    FBRequest *request = [FBRequest requestForMyFriends];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (!error) {
            NSArray *data = [result objectForKey:@"data"];
            self.friends = data;
            [self.interestsTableView reloadData];
        }
    }];
}

- (void)setupRecent
{
    //get array of recent players played with by userid
    
    //setup recent label
    UIColor * color = [UIColor colorWithRed:41/255.0f green:178/255.0f blue:177/255.0f alpha:1.0f];
    UILabel *recentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 300, 20)];
    
    
    [recentLabel setTextColor:color];
    [recentLabel setBackgroundColor:[UIColor clearColor]];
    [recentLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:22]];
    
    recentLabel.text = @"Recent";
    [self.view addSubview:recentLabel];
    
    //draw line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 110, 270, 2)];
    lineView.backgroundColor = color;
    [self.view addSubview:lineView];
    
    //setup table view? shit idk how to do thisss
    
}

- (void)setupSearchField
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Table View Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 25; //number of alphabet letters + recent
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ((self.sections[section] == @"Recent") && self.friends) {
        return [self.friends count];
    }
    return 5;//should return count per thing. dictionary maybe?
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @""; // Doesn't matter b/c we're using custom viewForHeaderInSection
}

//Header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // need to be dynamic later
    self.sections = @[@"Recent", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    
    //setup recent label
    UIColor * color = [UIColor colorWithRed:41/255.0f green:178/255.0f blue:177/255.0f alpha:1.0f];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    
    
    [headerLabel setTextColor:color];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:22]];
    
    headerLabel.text = self.sections[section];
    [view addSubview:headerLabel];
    
    //draw line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 270, 2)];
    lineView.backgroundColor = color;
    [view addSubview:lineView];
    
    //setup clear
    [view setBackgroundColor:self.bgColor];
    return view;
}

//for each cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //what?
    //    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    //    [recognizer setNumberOfTapsRequired:1];
    //    self.view.userInteractionEnabled = YES;
    //    [self.view addGestureRecognizer:recognizer];
    
    static NSString *MyIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    FBGraphObject<FBGraphUser> *tempPerson = self.friends[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [tempPerson first_name], [tempPerson last_name]];
    
    cell.textLabel.text = @"meowwww";
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    PFQuery *playerQuery = [PFUser query];
//    [playerQuery whereKey:@"fbId" equalTo:self.friends[indexPath.row][@"id"]];
//    [playerQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        if (!object || error) {
//            return;
//        }
//        PFUser *player = (PFUser *)object;
//        if (cell.accessoryType == UITableViewCellAccessoryNone) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            [self.players addObject:player];
//             NSLog(@"added player %@", player);
//        } else {
//            // deselected
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            NSString *tmp;
//            
//            for (int i; i < [self.players count]; i++) {
//                if (self.players[i] == player) {
//                    NSLog(@"removed player %@", player);
//                    [self.players removeObjectAtIndex:i];
//                    break;
//                }
//            }
//            
//        }
//        
//    }];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        // deselected
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)changeBG
{
    self.view.backgroundColor = self.bgColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
