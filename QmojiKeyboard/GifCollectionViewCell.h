//
//  GifCollectionViewCell.h
//  Qmoji
//
//  Created by Q on 5/6/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GifCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (nonatomic, strong) UIImageView *lockImageView;
- (void)setImageWithURL:(NSString *)urlString andIsPaid:(BOOL)isLock andCateName:(NSString *)cateName;

@end
