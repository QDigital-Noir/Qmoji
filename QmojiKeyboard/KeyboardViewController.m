//
//  KeyboardViewController.m
//  QmojiKeyboard
//
//  Created by Q on 4/24/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "KeyboardViewController.h"
#import "QmojiKeyboard.h"
#import "UIDeviceHardware.h"

@interface KeyboardViewController () <UIScrollViewDelegate>
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
    
    UIDeviceHardware *h = [[UIDeviceHardware alloc] init];
    NSLog(@"%@", [h platformString]);
    
    self.qmojiKeyboard = [[[NSBundle mainBundle] loadNibNamed:@"QmojiKeyboard" owner:nil options:nil] objectAtIndex:0];
    self.qmojiKeyboard.scrollView.delegate = self;

    float width = 0;
    float heigh = 0;
    
    if ([[h platformString] isEqualToString:@"iPhone 6"])
    {
        self.qmojiKeyboard.frame = CGRectMake(0, 0, 375, 258);
        self.qmojiKeyboard.scrollView.frame = CGRectMake(0, 0, self.qmojiKeyboard.frame.size.width, 158);
        self.qmojiKeyboard.scrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.globalButton.frame = CGRectMake(0, self.qmojiKeyboard.scrollView.frame.size.height, 45, 55);
        self.qmojiKeyboard.statusLabel.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.scrollView.frame.size.height, 375 - 90, 55);
        self.qmojiKeyboard.statusLabel.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.deleteButton.frame = CGRectMake(375 - 45, self.qmojiKeyboard.scrollView.frame.size.height, 45, 55);
        width = 125;
        heigh = 79;
    }
    else if ([[h platformString] isEqualToString:@"iPhone 6 Plus"])
    {
        self.qmojiKeyboard.frame = CGRectMake(0, 0, 414, 271);
        self.qmojiKeyboard.scrollView.frame = CGRectMake(0, 0, 414, 170);
        self.qmojiKeyboard.scrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.globalButton.frame = CGRectMake(0, self.qmojiKeyboard.scrollView.frame.size.height, 45, 50);
        self.qmojiKeyboard.statusLabel.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.scrollView.frame.size.height, 414 - 90, 50);
        self.qmojiKeyboard.statusLabel.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.deleteButton.frame = CGRectMake(414 - 45, self.qmojiKeyboard.scrollView.frame.size.height, 45, 50);
        
        width = 137;
        heigh = 85;
    }
    else
    {
        self.qmojiKeyboard.frame = CGRectMake(0, 0, 320, 253);
        self.qmojiKeyboard.scrollView.frame = CGRectMake(0, 0, 320, 158);
        self.qmojiKeyboard.scrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.globalButton.frame = CGRectMake(0, self.qmojiKeyboard.scrollView.frame.size.height, 45, 50);
        self.qmojiKeyboard.statusLabel.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.scrollView.frame.size.height, 320 - 90, 50);
        self.qmojiKeyboard.statusLabel.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.deleteButton.frame = CGRectMake(320 - 45, self.qmojiKeyboard.scrollView.frame.size.height, 45, 50);
        
        width = 125;
        heigh = 79;
    }
    
    NSArray *array = [[Helper sharedHelper] getUserCollection];
    NSLog(@"array : %@", array);
    
    float xpos = 0;
    float ypos = 0;
    
    for (int i = 0; i < array.count; i++)
    {
        NSDictionary *dict = array[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xpos, ypos, width, heigh);
        button.contentMode = UIViewContentModeScaleToFill;
        button.userInteractionEnabled = YES;
        button.backgroundColor = [UIColor grayColor];
        button.tag = i;
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:dict[@"giphyFixedWidth"]]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                [button setImage:[UIImage imageWithData: data] forState:UIControlStateNormal];
            });
        });
         
        [button addTarget:self action:@selector(copy:) forControlEvents:UIControlEventTouchUpInside];

        if (i % 2 == 0)
        {
            ypos = ypos + heigh + 1;
            self.qmojiKeyboard.scrollView.contentSize = CGSizeMake(xpos + width + 1, self.qmojiKeyboard.scrollView.frame.size.height);
        }
        else
        {
            xpos = xpos + width + 1;
            ypos = 0;
            self.qmojiKeyboard.scrollView.contentSize = CGSizeMake(xpos + width, self.qmojiKeyboard.scrollView.frame.size.height);
        }
        [self.qmojiKeyboard.scrollView addSubview:button];
    }
    
    self.inputView = self.qmojiKeyboard;
    [self addGuestureToKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
//    NSLog(@"Test 1");
//    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];//[UIPasteboard pasteboardWithName:@"CopyPaste" create:YES];
//    //    appPasteBoard.persistent = YES;
//    NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"keyboardcat.gif"]);
//    [appPasteBoard setData:data forPasteboardType:@"com.intencemedia.animatedgifkeyboard"];
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

#pragma mark - Qmoji Keyboard
- (void)addGuestureToKeyboard
{
    [self.qmojiKeyboard.deleteButton addTarget:self
                                        action:@selector(pressDeleteKey)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.qmojiKeyboard.globalButton addTarget:self
                                        action:@selector(advanceToNextInputMode)
                              forControlEvents:UIControlEventTouchUpInside];
}

- (void)pressDeleteKey
{
    [self.textDocumentProxy deleteBackward];
}

#pragma mark - Copy function

- (void)copy:(id)sender
{
    NSLog(@"Test : %ld", (long)[sender tag]);
    NSArray *collectionArray = [[Helper sharedHelper] getUserCollection];
    NSDictionary *dict = (NSDictionary *)collectionArray[[sender tag]];
    
    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"giphyOriginal"]]];
    [appPasteBoard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
    [self.textDocumentProxy insertText:[appPasteBoard string]];
}

@end
