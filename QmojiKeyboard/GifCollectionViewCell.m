//
//  GifCollectionViewCell.m
//  Qmoji
//
//  Created by Q on 5/6/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "GifCollectionViewCell.h"

@implementation GifCollectionViewCell

- (void)setImageWithURL:(NSString *)urlString andIsPaid:(BOOL)isLock andCateName:(NSString *)cateName
{
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]
                   placeholderImage:[UIImage imageNamed:@"placeholder"]
                            options:SDWebImageRefreshCached];
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
            self.lockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            self.lockImageView.image = [UIImage imageNamed:@"cart_icon"];
            self.lockImageView.backgroundColor = [UIColor clearColor];
            self.lockImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.lockImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            [self.image1 addSubview:self.lockImageView];
        }
    }
}

- (void)prepareForReuse
{
    self.lockImageView.image = nil;
}
@end
