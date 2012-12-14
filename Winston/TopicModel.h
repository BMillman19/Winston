//
//  TopicModel.h
//  Winston
//
//  Created by Brandon Millman on 12/13/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic, copy) NSString *topic;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, readonly) NSString *wikiURL;

@end
