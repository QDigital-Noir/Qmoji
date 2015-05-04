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
    self.qmojiKeyboard.cateScrollView.delegate = self;

    float width = 0;
    float heigh = 0;
    
    if ([[h platformString] isEqualToString:@"iPhone 6"])
    {
        self.qmojiKeyboard.frame = CGRectMake(0, 0, 375, 258);
        self.qmojiKeyboard.scrollView.frame = CGRectMake(0, 0, self.qmojiKeyboard.frame.size.width, 158);
        self.qmojiKeyboard.scrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.globalButton.frame = CGRectMake(0, self.qmojiKeyboard.scrollView.frame.size.height, 45, 55);
        self.qmojiKeyboard.cateScrollView.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.scrollView.frame.size.height, 375 - 90, 55);
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor redColor];
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
        self.qmojiKeyboard.cateScrollView.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.scrollView.frame.size.height, 414 - 90, 50);
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor redColor];
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
        self.qmojiKeyboard.cateScrollView.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.scrollView.frame.size.height, 320 - 90, 50);
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor redColor];
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
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, width, heigh)];
        loadingView.activityIndicatorViewStyle = UIActionSheetStyleDefault;
        [loadingView startAnimating];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xpos, ypos, width, heigh)];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"giphyFixedWidth"]]
                     placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [loadingView stopAnimating];
                            }];
        
        UITapGestureRecognizer *guesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(keyboardMethod:)];
        [guesture setNumberOfTapsRequired:1];
        [guesture setNumberOfTouchesRequired:1];
        [imageView addGestureRecognizer:guesture];


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
        [self.qmojiKeyboard.scrollView addSubview:imageView];
    }
    
    // setup category
    float xxpos = 0;
    
    for (int i = 0; i < 10; i++)
    {
        UIButton *cateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cateButton.backgroundColor = [UIColor blueColor];
        cateButton.titleLabel.font = [UIFont fontWithName:@"JosefinSans-Light" size:24.0f];
        cateButton.titleLabel.textColor = [UIColor whiteColor];
        [cateButton setTitle:@"Category" forState:UIControlStateNormal];
        [cateButton setTitle:@"Category" forState:UIControlStateSelected];
        [cateButton addTarget:self action:@selector(categoryTapped:) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = [cateButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"JosefinSans-Light" size:24.0f]}];
        [cateButton setFrame:CGRectMake(xxpos, 0, size.width, self.qmojiKeyboard.cateScrollView.frame.size.height)];
        [self.qmojiKeyboard.cateScrollView addSubview:cateButton];
    
        xxpos = xxpos + size.width + 1;
        self.qmojiKeyboard.cateScrollView.contentSize = CGSizeMake(xxpos, self.qmojiKeyboard.cateScrollView.frame.size.height);
    }
    
    self.inputView = self.qmojiKeyboard;
    [self addGuestureToKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput
{
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput
{
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark)
    {
        textColor = [UIColor whiteColor];
    }
    else
    {
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

#pragma mark - Category Button

- (void)categoryTapped:(id)sender
{
    NSLog(@"CATEGORY");
}


#pragma marks - reloard keyboard

- (void)reloardKeyboard
{
    NSArray *array = [[Helper sharedHelper] getUserCollection];
    NSLog(@"array : %@", array);
    
    self.qmojiKeyboard = [[[NSBundle mainBundle] loadNibNamed:@"QmojiKeyboard" owner:nil options:nil] objectAtIndex:0];
    self.qmojiKeyboard.scrollView.delegate = self;
    self.qmojiKeyboard.cateScrollView.delegate = self;
    
    float width = 0;
    float heigh = 0;
    float xpos = 0;
    float ypos = 0;
    
    for (int i = 0; i < array.count; i++)
    {
        NSDictionary *dict = array[i];
        
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, width, heigh)];
        loadingView.activityIndicatorViewStyle = UIActionSheetStyleDefault;
        [loadingView startAnimating];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xpos, ypos, width, heigh)];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"giphyFixedWidth"]]
                     placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [loadingView stopAnimating];
                            }];
        
        UITapGestureRecognizer *guesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(keyboardMethod:)];
        [guesture setNumberOfTapsRequired:1];
        [guesture setNumberOfTouchesRequired:1];
        [imageView addGestureRecognizer:guesture];
        
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
        [self.qmojiKeyboard.scrollView addSubview:imageView];
    }
}

- (void)keyboardMethod:(id)sender
{
    NSLog(@"%ld", (long)[(UIGestureRecognizer *)sender view].tag);
    int index = (int)[(UIGestureRecognizer *)sender view].tag;
    NSArray *collectionArray = [[Helper sharedHelper] getUserCollection];
    NSDictionary *dict = (NSDictionary *)collectionArray[index];
    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"giphyFixedWidth"]]];
    [appPasteBoard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:3]];
    [self.textDocumentProxy insertText:[appPasteBoard string]];
}

@end
