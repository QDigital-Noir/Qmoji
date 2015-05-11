//
//  MenuViewController.m
//  Qmoji
//
//  Created by Q on 4/25/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "AppDelegate.h"


@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *images;
    NSArray *menus;
    NSArray *categories;
}
@end

@implementation MenuViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    menus = @[@"Favorite", @"Unlock all gifs for $4.99", @"Restore", @"Get more apps"];
    categories = @[@"Feels",
                   @"Sleep",
                   @"Happy",
                   @"Sad",
                   @"Hungry",
                   @"Food",
                   @"Dance",
                   @"Dog",
                   @"Cat",
                   @"Celebrity",
                   @"Drunk",
                   @"Tired",
                   @"Bored",
                   @"Confused",
                   @"Mind Blown",
                   @"Beer",
                   @"Love",
                   @"Cars",
                   @"Deal With It",
                   @"Reaction",
                   @"Emotion",
                   @"Party",
                   @"Cry",
                   @"Laugh",
                   @"Awkward",
                   @"Face palm",
                   @"Birthday",
                   @"LOL",
                   @"Kiss",
                   @"Roll eyes",
                   @"Thumbs up",
                   @"Thumbs down",
                   @"Shrug",
                   @"Wink",
                   @"High Five"];
    
//    categories = [anArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.menuTableView.backgroundColor = [UIColor clearColor];
    [self.menuTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return menus.count;
    }
    else
    {
        return categories.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = [menus objectAtIndex:indexPath.row];
//        cell.imageView.image = [UIImage imageNamed:[menus objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.textLabel.text = [categories objectAtIndex:indexPath.row];
//        cell.imageView.image = [UIImage imageNamed:[categories objectAtIndex:indexPath.row]];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"JosefinSans-SemiBold" size:20.0f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            // My collection
            [[AppDelegate mainDelegate] setCollectionView];
        }
        else if (indexPath.row == 1)
        {
            // Unlock all
            NSLog(@"Buying all : %@", [[Helper sharedHelper] getIAPIdentifierWithKey:@"All"]);
            KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];
            basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
            basicConfiguration.fullScreen = YES;
            [KVNProgress showWithStatus:@"Loading..."];
            
            [PFPurchase buyProduct:[[Helper sharedHelper] getIAPIdentifierWithKey:@"All"] block:^(NSError *error) {
                if (!error)
                {
                    // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
                    NSLog(@"Unlock all gifs Success");
                    [KVNProgress dismiss];
                }
                else
                {
                    NSLog(@"IAP Error : %@", error.localizedDescription);
                    [KVNProgress showErrorWithStatus:@"Error"];
                }
            }];
        }
        else if (indexPath.row == 2)
        {
            // Restore purcheased
            KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];;
            basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
            basicConfiguration.fullScreen = YES;
            [KVNProgress showWithStatus:@"Restoring purchased..."];
            [PFPurchase restore];
        }
        else
        {
            // Get more app
            NSString *iTunesLink = @"https://itunes.apple.com/us/artist/intence-media/id592330573";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            [[AppDelegate mainDelegate] setFirstView];
            AppDelegateAccessor.categoryName = @"Trending";
        }
        else
        {
            AppDelegateAccessor.categoryName = categories[indexPath.row];
            [[AppDelegate mainDelegate] setCateView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGED_CATEGORY" object:nil];
        }
    }
}

@end
