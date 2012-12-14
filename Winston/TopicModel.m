//
//  TopicModel.m
//  Winston
//
//  Created by Brandon Millman on 12/13/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

@synthesize topic, images, wikiURL;

#pragma mark - Custom Accessors

- (NSString *)wikiURL
{
    return [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", self.topic];
}

@end
