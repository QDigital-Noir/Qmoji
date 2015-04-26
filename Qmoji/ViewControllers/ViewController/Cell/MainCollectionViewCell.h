//
//  MainCollectionViewCell.h
//  Qmoji
//
//  Created by Q on 4/26/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

- (void)setImageWithURL:(NSString *)urlString andIsPaid:(BOOL)isPaid andCateName:(NSString *)cateName;

@end
