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
//    [self.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]
//                   placeholderImage:[UIImage imageNamed:@"placeholder"]
//                            options:SDWebImageRefreshCached];
    
    NSArray *filepath = [urlString componentsSeparatedByString:@"."];
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filepath[0] ofType:@"gif"]]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0.0, 0.0, self.image1.frame.size.width, self.image1.frame.size.height);
    [self.image1 addSubview:imageView];
    
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
