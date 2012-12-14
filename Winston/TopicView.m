//
//  TopicView.m
//  Winston
//
//  Created by Brandon Millman on 12/13/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import "TopicView.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "TopicModel.h"

@interface TopicView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIWebView *infoView;
@property (nonatomic, assign) BOOL isShowingImageView;

@end

@implementation TopicView

#pragma mark - UIView

- (void)dealloc
{
    [self cancelFillRequests];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // set up looks
        self.backgroundColor = [UIColor blueColor];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowOffset = CGSizeMake(0, 2.0f);
        self.layer.shadowRadius = 5.0f;
        self.layer.masksToBounds = NO;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, -5, -5)].CGPath;
        
        // set up image view
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.backgroundColor = [UIColor orangeColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.userInteractionEnabled = NO;
        [self addSubview:self.imageView];
        
        // set up info view
        self.infoView = [[UIWebView alloc] initWithFrame:CGRectZero];
        self.infoView.backgroundColor = [UIColor redColor];
        [self insertSubview:self.infoView belowSubview:self.imageView];
        self.isShowingImageView = YES;
    }
    return self;
}

- (void)layoutSubviews
{    
    self.imageView.frame = CGRectInset(self.bounds, 10, 10);
    self.infoView.frame = CGRectInset(self.bounds, 10, 10);

//    CGRect leftHalfRect = CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y, self.contentView.bounds.size.width/2, self.contentView.bounds.size.height);
//    CGRect rightHalfRect = CGRectMake(self.contentView.bounds.origin.x + self.contentView.bounds.size.width/2, self.contentView.bounds.origin.y, self.contentView.bounds.size.width/2, self.contentView.bounds.size.height);
//    
//    self.imageView.frame = CGRectInset(leftHalfRect, 10, 10);
//    self.infoView.frame = CGRectInset(rightHalfRect, 10, 10);
}

#pragma mark - Instance Methods

- (void)fillWithTopicModel:(TopicModel *)model
{
    [self.infoView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.wikiURL]]];
    [self.imageView setImageWithURL:[NSURL URLWithString:model.images[0]]];
}

- (void)cancelFillRequests
{
    
}

- (void)flip
{
    self.isShowingImageView = !self.isShowingImageView;
    
    if (self.isShowingImageView) {
        [UIView transitionFromView:self.infoView toView:self.imageView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromTop completion:^(BOOL finished){}
         ];
    } else {
        [UIView transitionFromView:self.imageView toView:self.infoView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromBottom completion:^(BOOL finished){}
         ];
    }
}

@end
