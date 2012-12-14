//
//  ConversationViewController.m
//  Winston
//
//  Created by Brandon Millman on 12/12/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import "ConversationViewController.h"
#import "WinstonTopicEngine.h"
#import "iCarousel.h"
#import "TopicView.h"
#import "TopicModel.h"
#import "TopicCenter.h"

@interface ConversationViewController () <WinstonTopicEngineDelegate, iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) WinstonTopicEngine *topicEngine;
@property (nonatomic, strong) NSMutableArray *topics;

@end

@implementation ConversationViewController

@synthesize topicLabel = _topicLabel;
@synthesize topicCarousel = _topicCarousel;
@synthesize topicEngine = _topicEngine;
@synthesize topics = _topics;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up look
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"az_subtle"]];
    
    // set up topic carousel
    self.topicCarousel.type = iCarouselTypeCoverFlow2;
    self.topicCarousel.dataSource = self;
    self.topicCarousel.delegate = self;
    self.topicCarousel.backgroundColor = [UIColor clearColor];
    self.topicCarousel.layer.masksToBounds = NO;
    
    // set up topic engine
    self.topicEngine = [[WinstonTopicEngine alloc] init];
    self.topicEngine.delegate = self;
    
    // set up topics
    self.topics = [NSMutableArray array];
    TopicModel *model1 = [[TopicModel alloc] init];
    model1.topic = @"apple";
    TopicModel *model2 = [[TopicModel alloc] init];
    model2.topic = @"car";
    TopicModel *model3 = [[TopicModel alloc] init];
    model3.topic = @"lemonade";
    
//    [[TopicCenter sharedCenter] getTopic:@"apple" response:^(TopicModel *model, NSError *error){
//        [self.topics addObject:model];
//        [self.topicCarousel reloadData];
//    }];
//    
//    [[TopicCenter sharedCenter] getTopic:@"car" response:^(TopicModel *model, NSError *error){
//        [self.topics addObject:model];
//        [self.topicCarousel reloadData];
//    }];
//    
//    [[TopicCenter sharedCenter] getTopic:@"lemonade" response:^(TopicModel *model, NSError *error){
//        [self.topics addObject:model];
//        [self.topicCarousel reloadData];
//    }];


    //self.topics = [NSMutableArray arrayWithArray:@[model1, model2, model3]];
    

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (void)startButtonPressed:(id)sender
{
    [self.topicEngine start];
}

- (void)stopButtonPressed:(id)sender
{
    [self.topicEngine stop];
}

- (void)flipButtonPressed:(id)sender
{
    TopicView *topicView = (TopicView *)[self.topicCarousel currentItemView];
    [topicView flip];
}

#pragma mark - WinstonTopicEngineDelegate

- (void)topicEngine:(WinstonTopicEngine *)engine didFindTopic:(NSString *)topic
{
    NSLog(@"Current topic: %@", topic);
    self.topicLabel.text = topic;
    [self.topicLabel sizeToFit];
    [self.topicEngine start];
    
    [[TopicCenter sharedCenter] getTopic:topic response:^(TopicModel *model, NSError *error){
        [self.topics addObject:model];
        [self.topicCarousel reloadData];
    }];
}

#pragma mark - iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    if (!self.topics) return 0;
    else return self.topics.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    TopicView *topicView = (TopicView *)view;
    
    if (!view)
    {
        topicView = [[TopicView alloc] initWithFrame:CGRectMake(0, 0, carousel.bounds.size.width - (50 * 2), carousel.bounds.size.height - (50 * 2))];
    }
    
    //[topicView cancelFillRequests];
    [topicView fillWithTopicModel:self.topics[index]];
    
    return topicView;
}

#pragma mark - iCarouselDelegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    TopicView *topicView = (TopicView *)[self.topicCarousel itemViewAtIndex:index];
    [topicView flip];
}

#pragma mark - Custom Accessors

- (void)setTopics:(NSMutableArray *)topics
{
    _topics = topics;
    [self.topicCarousel reloadData];
}


@end
