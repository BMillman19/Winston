//
//  ConversationViewController.h
//  Winston
//
//  Created by Brandon Millman on 12/12/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iCarousel;

@interface ConversationViewController : UIViewController

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)flipButtonPressed:(id)sender;


@property (nonatomic, weak) IBOutlet UILabel *topicLabel;
@property (nonatomic, weak) IBOutlet iCarousel *topicCarousel;
@property (nonatomic, weak) IBOutlet UIView *controlBarView;

@end
