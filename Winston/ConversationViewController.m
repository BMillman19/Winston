//
//  ConversationViewController.m
//  Winston
//
//  Created by Brandon Millman on 12/12/12.
//  Copyright (c) 2012 Equinox. All rights reserved.
//

#import "ConversationViewController.h"
#import "WinstonTopicEngine.h"

@interface ConversationViewController () <WinstonTopicEngineDelegate>

@property (nonatomic, strong) WinstonTopicEngine *topicEngine;

@end

@implementation ConversationViewController

@synthesize topicLabel = _topicLabel;
@synthesize topicEngine = _topicEngine;

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
    
    // set up topic engine
    self.topicEngine = [[WinstonTopicEngine alloc] init];
    self.topicEngine.delegate = self;
    
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

#pragma mark - WinstonTopicEngineDelegate

- (void)topicEngine:(WinstonTopicEngine *)engine didFindTopic:(NSString *)topic
{
    NSLog(@"Current topic: %@", topic);
    self.topicLabel.text = topic;
    [self.topicLabel sizeToFit];
}

@end
