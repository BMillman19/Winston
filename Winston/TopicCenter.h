//
//  TopicCenter.h
//  Winston
//
//  Created by Brandon Millman on 12/13/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@class TopicModel;

@interface TopicCenter : NSObject

+ (TopicCenter *)sharedCenter;

- (void)getTopic:(NSString *)topic response:(void (^)(TopicModel *model, NSError *error))response;

@end
