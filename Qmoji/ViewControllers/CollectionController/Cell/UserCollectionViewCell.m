//
//  UserCollectionViewCell.m
//  Qmoji
//
//  Created by Q on 4/27/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "UserCollectionViewCell.h"

@implementation UserCollectionViewCell

- (void)setImageWithURL:(NSString *)urlString andIsPaid:(BOOL)isPaid andCateName:(NSString *)cateName
{
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]
                   placeholderImage:[UIImage imageNamed:@"placeholder"]
                            options:SDWebImageRefreshCached];
    self.image1.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)prepareForReuse
{
    //    self.lockedImageView.image = nil;
}
@end
