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
    images = @[@"", @"", @"", @"", @"", @""];
    menus = @[@"My Collections", @"Restore", @"Get more apps"];
    categories = @[@"Trending", @"Animals", @"Sci-Fi", @"Movies", @"Funnies", @"Meme", @"Cartoons", @"Love", @"Zombies"];
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = [menus objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[menus objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.textLabel.text = [categories objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[categories objectAtIndex:indexPath.row]];
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
            // Restore purcheased
            KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];;
            basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
            basicConfiguration.fullScreen = YES;
            [KVNProgress showWithStatus:@"Restoring purcheased..."];
//            [PFPurchase restore];
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
        }
        else
        {
            AppDelegateAccessor.categoryName = categories[indexPath.row];
            [[AppDelegate mainDelegate] setCateView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGED_CATEGORY" object:nil];
        }
        
//        if (AppDelegateAccessor.isFromCollectionScreen)
//        {
//            [[AppDelegate mainDelegate] setCateView];
//        }
//        else
//        {
//            if (AppDelegateAccessor.isFromTrendingScreen)
//            {
//                [[AppDelegate mainDelegate] setCateView];
//            }
//            else
//            {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGED_CATEGORY" object:nil];
//                [[AppDelegate mainDelegate].slideMenuVC toggleMenu];
//            }
//        }
        
//        if (AppDelegateAccessor.isFromCollectionScreen == NO && AppDelegateAccessor.isFromTrendingScreen == NO)
//        {
//            // From Category to Trending
//            [[AppDelegate mainDelegate] setFirstView];
//        }
//        else if (AppDelegateAccessor.isFromCollectionScreen == YES && AppDelegateAccessor.isFromTrendingScreen == NO)
//        {
//            // From Collection to Trending
//            [[AppDelegate mainDelegate] setFirstView];
//        }
//        else if (AppDelegateAccessor.isFromCollectionScreen == NO && AppDelegateAccessor.isFromTrendingScreen == YES)
//        {
//            // From Trending
//            [[AppDelegate mainDelegate] setCateView];
//        }
    }
}

@end
