//
//  GatherInterestsViewController.h
//  Gather
//
//  Created by Lucy Guo on 7/10/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GatherInterestsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *interestsTableView;
@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) NSMutableArray *players;
@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) UIColor *bgColor;


@end
