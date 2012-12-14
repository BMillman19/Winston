//
//  RotatingImageView.h
//  Winston
//
//  Created by Brandon Millman on 12/14/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotatingImageView : UIView

- (void)startAnimating;
- (void)stopAnimating;

@property (nonatomic, copy) NSArray *images;

@end
