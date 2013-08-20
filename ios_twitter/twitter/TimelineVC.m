//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "TweetVC.h"
#import "NewTweetVC.h"

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;

- (void)onSignOutButton;
- (void)reload;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"New.png"] style:UIBarButtonItemStylePlain target:self action:@selector(createNewTweet)];
    
    UINib *editableCellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:editableCellNib forCellReuseIdentifier:@"TweetCell"];
    
   // self.tableView.dataSource = self;


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = self.tweets[indexPath.row];
    
    static NSString *CellIdentifier = @"TweetCell";

    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CGSize labelSize = [tweet.text sizeWithFont:cell.tweetLabel.font constrainedToSize:CGSizeMake(cell.tweetLabel.bounds.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    CGFloat bodyHeight = labelSize.height;
    
    cell.tweetLabel.frame = CGRectMake(cell.tweetLabel.frame.origin.x, cell.tweetLabel.frame.origin.y, cell.tweetLabel.frame.size.width, bodyHeight);
    cell.tweetLabel.numberOfLines = 0;
    cell.tweetLabel.text = tweet.text;
    
    cell.usernameLabel.text = tweet.username;
    cell.handleLabel.text = tweet.handle;
    cell.timestampLabel.text = tweet.tweetAge;
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:tweet.profileImageUrl]];
    cell.profileImage.image = [UIImage imageWithData:imageData];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TweetVC *tweetVC = [[TweetVC alloc] initWithNibName:@"TweetVC" bundle:nil];
    Tweet *tweet = self.tweets[indexPath.row];
    tweetVC.tweet = tweet;
  
    [self.navigationController pushViewController:tweetVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    Tweet *tweet = self.tweets[indexPath.row];
    
    CGSize labelSize = [tweet.text sizeWithFont:cell.tweetLabel.font constrainedToSize:CGSizeMake(cell.tweetLabel.bounds.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    CGFloat bodyHeight = labelSize.height;
    
    return bodyHeight+50.0;
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}


- (void)createNewTweet {
    NewTweetVC *newTweetVC = [[NewTweetVC alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newTweetVC];
    
    navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}



@end
