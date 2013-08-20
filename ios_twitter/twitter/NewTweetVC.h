//
//  NewTweetVC.h
//  twitter
//
//  Created by Pulkit Goel on 8/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTweetVC : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) NSString *replyToStatusID;

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end
