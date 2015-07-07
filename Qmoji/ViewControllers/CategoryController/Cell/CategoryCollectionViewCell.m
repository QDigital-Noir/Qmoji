//
//  CategoryCollectionViewCell.m
//  Qmoji
//
//  Created by Q on 4/27/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

- (void)setImageWithURL:(NSString *)urlString andIsPaid:(BOOL)isLock andCateName:(NSString *)cateName
{
    NSLog(@"urlString : %@", urlString);
    
//    [self.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]
//                   placeholderImage:[UIImage imageNamed:@"placeholder"]
//                            options:SDWebImageRefreshCached];
    
    self.image1.image = [UIImage imageNamed:@"1PUzYSVDY7Nug.gif"];
    self.image1.contentMode = UIViewContentModeScaleAspectFill;
    
    BOOL isUnlock = [[Helper sharedHelper] getUnlockedStickerWithKey:cateName];
    BOOL isUnlockAll = [[Helper sharedHelper] getUnlockedStickerWithKey:@"All"];
    if (isUnlock || isUnlockAll)
    {
        NSLog(@"No overlay");
    }
    else
    {
        if (isLock)
        {
            self.lockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            self.lockImageView.image = [UIImage imageNamed:@"cart_icon"];
            self.lockImageView.backgroundColor = [UIColor clearColor];
            self.lockImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.image1 addSubview:self.lockImageView];
        }
    }
}

- (void)prepareForReuse
{
    self.lockImageView.image = nil;
}
@end
