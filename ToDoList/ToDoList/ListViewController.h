//
//  ListViewController.h
//  ToDoList
//
//  Created by Pulkit Goel on 8/9/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
