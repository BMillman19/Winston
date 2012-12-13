//
//  AppDelegate.h
//  Winston
//
//  Created by Brandon Millman on 12/12/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConversationViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ConversationViewController *conversationViewController;

@end
