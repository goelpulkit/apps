//
//  TweetVC.m
//  twitter
//
//  Created by Pulkit Goel on 8/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetVC.h"
#import "NewTweetVC.h"

@interface TweetVC ()

@end

@implementation TweetVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    CGSize labelSize = [self.tweet.text sizeWithFont:self.tweetLabel.font constrainedToSize:CGSizeMake(self.tweetLabel.bounds.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    CGFloat bodyHeight = labelSize.height;
  
    
    self.tweetLabel.frame = CGRectMake(self.tweetLabel.frame.origin.x, self.tweetLabel.frame.origin.y, self.tweetLabel.frame.size.width, bodyHeight);

    self.tweetLabel.numberOfLines = 0;
    self.tweetLabel.text = self.tweet.text;
    self.usernameLabel.text = self.tweet.username;
    self.timestampLabel.text = self.tweet.timestamp;
    self.handleLabel.text = self.tweet.handle;
   
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.tweet.profileImageUrl]];
    self.profileImage.image = [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) onReplyButton{
    NewTweetVC *newTweetVC = [[NewTweetVC alloc] init];
    newTweetVC.replyToStatusID = [self.tweet id_str];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newTweetVC];
    
    navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction) onRetweetButton{
    [[TwitterClient instance] retweet:[self.tweet id_str] success:^(AFHTTPRequestOperation *operation, id response) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *uiAlert = [[UIAlertView alloc] initWithTitle: @"Alert"
                                                          message: @"Retweet action failed"
                                                         delegate: nil
                                                cancelButtonTitle: @"Cancel"
                                                otherButtonTitles: nil];
        [uiAlert show];
    }];
}

- (IBAction) onFavoriteButton{
    [[TwitterClient instance] favorite:[self.tweet id_str] success:^(AFHTTPRequestOperation *operation, id response) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *uiAlert = [[UIAlertView alloc] initWithTitle: @"Alert"
                                                          message: @"Favorite action failed"
                                                         delegate: nil
                                                cancelButtonTitle: @"Cancel"
                                                otherButtonTitles: nil];
        [uiAlert show];
    }];
    
    
}

@end
