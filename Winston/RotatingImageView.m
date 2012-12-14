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

@end

@implementation RotatingImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView1.clipsToBounds = YES;
        [self addSubview:self.imageView1];
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView2.clipsToBounds = YES;
        [self insertSubview:self.imageView2 belowSubview:self.imageView1];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.imageView1.frame = self.bounds;
    self.imageView2.frame = self.bounds;
}

#pragma mark - Custom Accessors

- (void)setImages:(NSArray *)images
{
    _images = [images copy];
}

@end
