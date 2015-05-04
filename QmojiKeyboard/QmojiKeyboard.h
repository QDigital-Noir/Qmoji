//
//  QmojiKeyboard.h
//  Qmoji
//
//  Created by Q on 4/24/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QmojiKeyboard : UIView
@property (weak, nonatomic) IBOutlet UIButton *globalButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *cateScrollView;

@end
