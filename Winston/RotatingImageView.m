//
//  RotatingImageView.m
//  Winston
//
//  Created by Brandon Millman on 12/14/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import "RotatingImageView.h"
#import "UIImageView+AFNetworking.h"

@interface RotatingImageView ()

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) NSTimer *rotateTimer;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation RotatingImageView

@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize rotateTimer = _rotateTimer;

- (void)dealloc
{
    [_rotateTimer invalidate];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView1.clipsToBounds = YES;
        self.imageView1.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView1];
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView2.clipsToBounds = YES;
        self.imageView2.backgroundColor = [UIColor whiteColor];
        [self insertSubview:self.imageView2 belowSubview:self.imageView1];
        
        self.currentIndex = 0;
    }
    return self;
}

- (void)layoutSubviews
{
    self.imageView1.frame = self.bounds;
    self.imageView2.frame = self.bounds;
}

#pragma mark - Instance Methods

- (void)startAnimating
{
    self.rotateTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(moveToNextImage) userInfo:nil repeats:YES];
}

- (void)stopAnimating
{
    [self.rotateTimer invalidate];
    self.rotateTimer = nil;
}

- (void)moveToNextImage
{
    BOOL view1InFront = self.currentIndex % 2 == 0;
    self.currentIndex++;
    if (self.currentIndex == self.images.count) {
        self.currentIndex = 0;
    }
    
    int nextIndex = (self.currentIndex + 1) == self.images.count ? 0 : (self.currentIndex + 1);
    
    if (view1InFront) {
        [UIView transitionFromView:self.imageView1 toView:self.imageView2 duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished){[self.imageView1 setImageWithURL:[NSURL URLWithString:self.images[nextIndex]]];}
         ];
    } else {
        [UIView transitionFromView:self.imageView2 toView:self.imageView1 duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished){[self.imageView2 setImageWithURL:[NSURL URLWithString:self.images[nextIndex]]];}
         ];
    }
    
    

}

#pragma mark - Custom Accessors

- (void)setImages:(NSArray *)images
{
    _images = [images copy];
    [self.imageView1 setImageWithURL:[NSURL URLWithString:images[0]]];
    if (images.count > 1)
    {
        [self.imageView2 setImageWithURL:[NSURL URLWithString:images[1]]];

    }
}

@end
