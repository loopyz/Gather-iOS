//
//  HomeViewController.m
//  Gather
//
//  Created by Lucy Guo on 7/10/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "HomeViewController.h"
#import "GatherInterestsViewController.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.bgColor = [UIColor colorWithRed:251/255.0f green:251/255.0f blue:251/255.0f alpha:1.0f];
        
        // Custom initialization
        [self changeBG];
        [self initNavBar];
        
        
        
        
    }
    return self;
}

- (void)initNavBar
{
    // Background image for navbar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbg.png"]
                                       forBarMetrics: UIBarMetricsDefault];
    
    // Left bar button item.
    UIBarButtonItem *lbb =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"person.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(launchCreateGatherView)];
    lbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 226, 59)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(55, 14, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
    // Right bar button item to launch the categories selection screen.
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus.png"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(launchCreateGatherView)];
    
    rbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = rbb;
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    
    //back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Create Game" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)assignTabColors
{
    switch (self.selectedIndex) {
        case 0: {
            UIColor * color = [UIColor colorWithRed:23/255.0f green:41/255.0f blue:166/255.0f alpha:1.0f];
            self.view.tintColor = color;
            break;
        }
            
        default:
            break;
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self assignTabColors];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self assignTabColors];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)changeBG
{
    self.view.backgroundColor = self.bgColor;
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

#pragma mark - Action Handlers

- (void)launchSettingsView
{
    return;
}

- (void)launchCreateGatherView
{
    GatherInterestsViewController *svc = [[GatherInterestsViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}


@end