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

#define kCellsPerRow 2

@interface KeyboardViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    float width;
    float heigh;
    float screenWidth;
}

@property (nonatomic, strong) QmojiKeyboard *qmojiKeyboard;
@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *categoryName;

@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // Set category array
    self.categoryArray = @[@"Favorite", @"Trending", @"Animals", @"Sci-Fi", @"Movies", @"Funnies", @"Meme", @"Cartoons", @"Love", @"Zombies"];
    
    // Setup data
    self.dataArray = [[Helper sharedHelper] getUserCollection];
    [self setupKeyboardWithArray:self.dataArray];
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
    self.dataArray = nil;

    if (tag == 0)
    {
        self.dataArray = [[Helper sharedHelper] getUserCollection];
    }
    else
    {
        self.dataArray = [[Helper sharedHelper] getCategoryData:self.categoryArray[tag]];
    }
    
    [self.qmojiKeyboard.collectionView reloadData];
    
    for (UIButton *button in self.qmojiKeyboard.cateScrollView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]])
        {
            if (tag == button.tag)
            {
                [button setSelected:YES];
            }
            else
            {
                [button setSelected:NO];
            }
        }
    }
}


#pragma marks - reloard keyboard

- (void)setupKeyboardWithArray:(NSArray *)dataArray
{
    UINib *cellNib = [UINib nibWithNibName:@"cell" bundle:nil];

    self.qmojiKeyboard = [[[NSBundle mainBundle] loadNibNamed:@"QmojiKeyboard" owner:nil options:nil] objectAtIndex:0];
    self.qmojiKeyboard.collectionView.delegate = self;
    self.qmojiKeyboard.collectionView.dataSource = self;
    [self.qmojiKeyboard.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
    
    UIDeviceHardware *h = [[UIDeviceHardware alloc] init];
    
    width = 0;
    heigh = 0;
    
    if ([[h platformString] isEqualToString:@"iPhone 6"])
    {
        self.qmojiKeyboard.frame = CGRectMake(0, 0, 375, 258);
        self.qmojiKeyboard.collectionView.frame = CGRectMake(0, 0, self.qmojiKeyboard.frame.size.width, 158);
        self.qmojiKeyboard.collectionView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.globalButton.frame = CGRectMake(0, self.qmojiKeyboard.collectionView.frame.size.height, 45, 55);
        self.qmojiKeyboard.cateScrollView.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.collectionView.frame.size.height, 375 - 90, 55);
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.deleteButton.frame = CGRectMake(375 - 45, self.qmojiKeyboard.collectionView.frame.size.height, 45, 55);
        
        width = 375/3;//125;
        heigh = 79;
        screenWidth = 375;
    }
    else if ([[h platformString] isEqualToString:@"iPhone 6 Plus"])
    {
        self.qmojiKeyboard.frame = CGRectMake(0, 0, 414, 271);
        self.qmojiKeyboard.collectionView.frame = CGRectMake(0, 0, 414, 170);
        self.qmojiKeyboard.collectionView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.globalButton.frame = CGRectMake(0, self.qmojiKeyboard.collectionView.frame.size.height, 45, 50);
        self.qmojiKeyboard.cateScrollView.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.collectionView.frame.size.height, 414 - 90, 50);
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.deleteButton.frame = CGRectMake(414 - 45, self.qmojiKeyboard.collectionView.frame.size.height, 45, 50);
        
        width = 414/3;//137;
        heigh = 85;
        screenWidth = 414;
    }
    else
    {
        self.qmojiKeyboard.frame = CGRectMake(0, 0, 320, 253);
        self.qmojiKeyboard.collectionView.frame = CGRectMake(0, 0, 320, 158);
        self.qmojiKeyboard.collectionView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.globalButton.frame = CGRectMake(0, self.qmojiKeyboard.collectionView.frame.size.height, 45, 50);
        self.qmojiKeyboard.cateScrollView.frame = CGRectMake(self.qmojiKeyboard.globalButton.frame.size.width, self.qmojiKeyboard.collectionView.frame.size.height, 320 - 90, 50);
        self.qmojiKeyboard.cateScrollView.backgroundColor = [UIColor clearColor];
        self.qmojiKeyboard.deleteButton.frame = CGRectMake(320 - 45, self.qmojiKeyboard.collectionView.frame.size.height, 45, 50);
        
        width = 320/3;//125;
        heigh = 79;
        screenWidth = 320;
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(width, heigh)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    [self.qmojiKeyboard.collectionView setCollectionViewLayout:flowLayout];
    
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
        [cateButton setBackgroundImage:[self setColor:[UIColor lightGrayColor] andFrame:CGRectMake(0, 0, size.width + 10, size.height)] forState:UIControlStateSelected];
        [cateButton setFrame:CGRectMake(xxpos, 0, size.width + 10, self.qmojiKeyboard.cateScrollView.frame.size.height)];
        [self.qmojiKeyboard.cateScrollView addSubview:cateButton];
        
        xxpos = xxpos + size.width + 20;
        self.qmojiKeyboard.cateScrollView.contentSize = CGSizeMake(xxpos, self.qmojiKeyboard.cateScrollView.frame.size.height);
        
        if (i == 0)
        {
            cateButton.selected = YES;
        }
    }
    
    self.inputView = self.qmojiKeyboard;
    [self addGuestureToKeyboard];
}

- (UIImage *)setColor:(UIColor *)color andFrame:(CGRect)frame
{
    UIView *colorView = [[UIView alloc] initWithFrame:frame];
    colorView.backgroundColor = color;
    
    UIGraphicsBeginImageContext(colorView.bounds.size);
    [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

#pragma mark - UICollectionView Delegate & Datasource
#pragma mark - UICollectionView DataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.frame = CGRectMake(0, 0, width, heigh);
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.hidesWhenStopped = YES;
    [spinner startAnimating];

    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.userInteractionEnabled = YES;
    spinner.center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
    [imageView addSubview:spinner];
    [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"giphyFixedWidth"]]
                 placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [spinner stopAnimating];
                            [spinner removeFromSuperview];
                        }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"TEST : %ld", (long)indexPath.row);
    NSDictionary *dict = (NSDictionary *)self.dataArray[indexPath.row];
    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"giphyFixedWidth"]]];
    [appPasteBoard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:3]];
    [self.textDocumentProxy insertText:[appPasteBoard string]];
}

@end
