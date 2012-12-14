//
//  TopicView.h
//  Winston
//
//  Created by Brandon Millman on 12/13/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicModel;

@interface TopicView : UIView

- (void)fillWithTopicModel:(TopicModel *)model;
- (void)cancelFillRequests;
- (void)flip;

@end
