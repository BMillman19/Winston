//
//  TopicCenter.m
//  Winston
//
//  Created by Brandon Millman on 12/13/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import "TopicCenter.h"
#import "AFNetworking.h"
#import "TopicModel.h"

#define kBaseURL @"https://www.googleapis.com/"
#define kSearchAPIKey @"AIzaSyCX5cj6i728u8eVD4RDMYNn0j0iZCkQI9s"

@interface TopicCenter ()

@property (nonatomic, strong) NSMutableDictionary *topicCache;
@property (nonatomic, strong) NSMutableData *searchResultsData;


@end

@implementation TopicCenter

@synthesize topicCache = _topicCache;
@synthesize searchResultsData = _searchResultsData;

// singleton factory
+ (TopicCenter *)sharedCenter
{
    static TopicCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[self alloc] init];
    });
    return center;
}

// private factory
- (id)init
{
    if (self = [super init]) {
        self.topicCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)getTopic:(NSString *)topic response:(void (^)(TopicModel *model, NSError *error))response
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@&resultFormat=text", topic]]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *httpResponse, id JSON) {
            //NSLog(@"%@", JSON);
            id responseData = [JSON objectForKey:@"responseData"];
            if ([responseData isKindOfClass:[NSDictionary class]])
            {
                id results = [responseData objectForKey:@"results"];
                if ([results isKindOfClass:[NSArray class]])
                {
                    NSMutableArray *imageArray = [NSMutableArray array];
                    TopicModel *model = [[TopicModel alloc] init];
                    model.topic = topic;
                    for (NSDictionary *imageDict in results)
                    {
                        [imageArray addObject:[imageDict objectForKey:@"url"]];
                    }
                    model.images = imageArray;
                    response(model, nil);
                }
            }
        }
                                                                                        failure:nil];
    
    [operation start];
}


@end
