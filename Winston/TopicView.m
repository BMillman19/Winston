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
#import "RotatingImageView.h"

@interface TopicView ()

@property (nonatomic, strong) RotatingImageView *rotatingImageView;
@property (nonatomic, strong) UIWebView *infoView;
@property (nonatomic, assign) BOOL isShowingImageView;

@end

@implementation TopicView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // set up looks
        self.backgroundColor = [UIColor colorWithRed:54.0/255.0 green:90.0/255.0 blue:141.0/255.0 alpha:1.0];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowOffset = CGSizeMake(0, 2.0f);
        self.layer.shadowRadius = 10.0f;
        self.layer.masksToBounds = NO;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, -5, -5)].CGPath;
        
        // set up image view
        self.rotatingImageView = [[RotatingImageView alloc] initWithFrame:CGRectZero];
        self.rotatingImageView.backgroundColor = [UIColor orangeColor];
        self.rotatingImageView.clipsToBounds = YES;
        self.rotatingImageView.userInteractionEnabled = NO;
        [self addSubview:self.rotatingImageView];
        
        // set up info view
        self.infoView = [[UIWebView alloc] initWithFrame:CGRectZero];
        self.infoView.backgroundColor = [UIColor redColor];
        self.infoView.userInteractionEnabled = NO;
        [self insertSubview:self.infoView belowSubview:self.rotatingImageView];
        self.isShowingImageView = YES;
    }
    return self;
}

- (void)layoutSubviews
{    
    self.rotatingImageView.frame = CGRectInset(self.bounds, 10, 10);
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
    self.rotatingImageView.images = model.images;
}

- (void)flip
{
    self.isShowingImageView = !self.isShowingImageView;
    
    if (self.isShowingImageView) {
        [UIView transitionFromView:self.infoView toView:self.rotatingImageView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromTop completion:^(BOOL finished){
            self.infoView.userInteractionEnabled = NO;
        }
         ];
    } else {
        [UIView transitionFromView:self.rotatingImageView toView:self.infoView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromBottom completion:^(BOOL finished){
                self.infoView.userInteractionEnabled = YES;
            }
         ];
    }
}

- (void)startAnimating
{
    [self.rotatingImageView startAnimating];
}

- (void)stopAnimating
{
    [self.rotatingImageView stopAnimating];
}

@end
