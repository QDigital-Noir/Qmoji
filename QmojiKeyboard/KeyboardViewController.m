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
@property (nonatomic, strong) NSArray *categoryArray;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set category array
    self.categoryArray = @[@"Trending", @"Animals", @"Sci-Fi", @"Movies", @"Funnies", @"Meme", @"Cartoons", @"Love", @"Zombies"];
    self.qmojiKeyboard = [[[NSBundle mainBundle] loadNibNamed:@"QmojiKeyboard" owner:nil options:nil] objectAtIndex:0];
    self.qmojiKeyboard.scrollView.delegate = self;
    self.qmojiKeyboard.cateScrollView.delegate = self;
    
    // Setup data
    NSArray *array = [[Helper sharedHelper] getUserCollection];
    [self reloardKeyboardWithArray:array];
    
    // setup category
    float xxpos = 0;
    
    for (int i = 0; i < self.categoryArray.count; i++)
    {
        UIButton *cateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cateButton.backgroundColor = [UIColor clearColor];
        cateButton.titleLabel.font = [UIFont fontWithName:@"JosefinSans-Light" size:24.0f];
        cateButton.titleLabel.textColor = [UIColor whiteColor];
        cateButton.tag = i;
        [cateButton setTitle:self.categoryArray[i] forState:UIControlStateNormal];
        [cateButton setTitle:self.categoryArray[i] forState:UIControlStateSelected];
        [cateButton addTarget:self action:@selector(categoryTapped:) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = [cateButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"JosefinSans-Light" size:24.0f]}];
        [cateButton setFrame:CGRectMake(xxpos, 0, size.width, self.qmojiKeyboard.cateScrollView.frame.size.height)];
        [self.qmojiKeyboard.cateScrollView addSubview:cateButton];
    
        xxpos = xxpos + size.width + 20;
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
    int tag = (int)[sender tag];
    NSArray *testArray = [[Helper sharedHelper] getCategoryData:self.categoryArray[tag]];
    NSLog(@"CATEGORY : %@", self.categoryArray[tag]);
    NSLog(@"Data : %@", testArray);
    [self reloardKeyboardWithArray:testArray];
}


#pragma marks - reloard keyboard

- (void)reloardKeyboardWithArray:(NSArray *)dataArray
{
    UIDeviceHardware *h = [[UIDeviceHardware alloc] init];
    
    float width = 0;
    float heigh = 0;
    
    if ([[h platformString] isEqualToString:@"iPhone 6"])
    {
        self.qmojiKeyboard.frame = CGRectMake(0, 0, 375, 258);
        self.qmojiKeyboard.scrollView.frame = CGRectMake(0, 0, self.qmojiKeyboard.frame.size.width, 158);
        self.qmojiKeyboard.scrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.globalButton.frame = CGRectMake(0, self.qmojiKeyboard.scrollView.frame.size.height, 45, 55);
        self.qmojiKeyboard.cateScrollView.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.scrollView.frame.size.height, 375 - 90, 55);
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor clearColor];
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
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor clearColor];
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
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.deleteButton.frame = CGRectMake(320 - 45, self.qmojiKeyboard.scrollView.frame.size.height, 45, 50);
        
        width = 125;
        heigh = 79;
    }
    
    for (UIView *view in self.qmojiKeyboard.scrollView.subviews)
    {
        [view removeFromSuperview];
    }

    float xpos = 0;
    float ypos = 0;
    
    for (int i = 0; i < dataArray.count; i++)
    {
        NSDictionary *dict = dataArray[i];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.hidesWhenStopped = YES;
        [spinner startAnimating];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xpos, ypos, width, heigh)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        spinner.center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
        [imageView addSubview:spinner];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"giphyFixedWidth"]]
                     placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [spinner stopAnimating];
                                [spinner removeFromSuperview];
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
    [self disableKeyboard];
}

- (void)enableKeyboard
{
    for (UIView *view in self.qmojiKeyboard.scrollView.subviews)
    {
        [view setUserInteractionEnabled:YES];
    }
}

- (void)disableKeyboard
{
    for (UIView *view in self.qmojiKeyboard.scrollView.subviews)
    {
        [view setUserInteractionEnabled:NO];
    }
    
    [self performSelector:@selector(enableKeyboard) withObject:nil afterDelay:0.5];
}

@end
