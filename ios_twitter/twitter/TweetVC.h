//
//  TweetVC.h
//  twitter
//
//  Created by Pulkit Goel on 8/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetVC : UIViewController

@property (nonatomic, strong) Tweet *tweet;

@property (nonatomic, weak) IBOutlet UIImageView *profileImage;
@property (nonatomic, weak) IBOutlet UILabel *tweetLabel;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel *handleLabel;
@property (nonatomic, weak) IBOutlet UILabel *timestampLabel;

- (IBAction) onReplyButton;
- (IBAction) onRetweetButton;
- (IBAction) onFavoriteButton;

@end
