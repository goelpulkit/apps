//
//  NewTweetVC.m
//  twitter
//
//  Created by Pulkit Goel on 8/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "NewTweetVC.h"

@interface NewTweetVC ()

@end

@implementation NewTweetVC

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissTweet)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sendTweet)];
    
    self.textView.delegate = self;
    
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dismissTweet {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)sendTweet {
    if(self.replyToStatusID){
        [[TwitterClient instance] postReply:self.textView.text replyTo:self.replyToStatusID success:^(AFHTTPRequestOperation *operation, id response) {
            [self dismissViewControllerAnimated:YES completion:^{}];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *uiAlert = [[UIAlertView alloc] initWithTitle: @"Alert"
                                                              message: @"Reply action failed"
                                                             delegate: nil
                                                    cancelButtonTitle: @"Cancel"
                                                    otherButtonTitles: nil];
            [uiAlert show];
        }];
    }else {
        [[TwitterClient instance] post:self.textView.text success:^(AFHTTPRequestOperation *operation, id response) {
            [self dismissViewControllerAnimated:YES completion:^{}];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *uiAlert = [[UIAlertView alloc] initWithTitle: @"Alert"
                                                              message: @"Post Tweet action failed"
                                                             delegate: nil
                                                    cancelButtonTitle: @"Cancel"
                                                    otherButtonTitles: nil];
            [uiAlert show];
        }];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return (newLength > 140) ? NO : YES;
}

@end
