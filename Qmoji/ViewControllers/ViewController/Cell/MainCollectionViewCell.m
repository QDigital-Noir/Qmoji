//
//  MainCollectionViewCell.m
//  Qmoji
//
//  Created by Q on 4/26/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell

- (void)setImageWithURL:(NSString *)urlString andIsPaid:(BOOL)isPaid andCateName:(NSString *)cateName
{
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]
                               options:SDWebImageRefreshCached];
    self.image1.contentMode = UIViewContentModeScaleAspectFill;
    
//    BOOL isUnlock = [[Helper sharedHelper] getUnlockedStickerWithKey:cateName];
//    BOOL isUnlockAll = [[Helper sharedHelper] getUnlockedStickerWithKey:@"All"];
//    if (isUnlock || isUnlockAll)
//    {
//        NSLog(@"No overlay");
//    }
//    else
//    {
//        if (isPaid)
//        {
//            self.lockedImageView.backgroundColor = [UIColor clearColor];
//            self.lockedImageView.image = [UIImage imageNamed:@"locked"];
//            self.lockedImageView.alpha = 0.6;
//        }
//    }
}

- (void)prepareForReuse
{
//    self.lockedImageView.image = nil;
}
@end
