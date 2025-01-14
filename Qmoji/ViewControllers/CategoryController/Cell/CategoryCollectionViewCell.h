//
//  CategoryCollectionViewCell.h
//  Qmoji
//
//  Created by Q on 4/27/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (nonatomic, strong) UIImageView *lockImageView;

- (void)setImageWithURL:(NSString *)urlString andIsPaid:(BOOL)isPaid andCateName:(NSString *)cateName;

@end
