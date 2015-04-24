//
//  KeyboardViewController.m
//  QmojiKeyboard
//
//  Created by Q on 4/24/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "KeyboardViewController.h"
#import "QmojiKeyboard.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) QmojiKeyboard *qmojiKeyboard;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Keyboard
    self.qmojiKeyboard = [[[NSBundle mainBundle] loadNibNamed:@"QmojiKeyboard" owner:nil options:nil] objectAtIndex:0];
    self.inputView = self.qmojiKeyboard;
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
}

@end
