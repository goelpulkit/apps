//
//  ListViewController.m
//  ToDoList
//
//  Created by Pulkit Goel on 8/9/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import "ListViewController.h"
#import "Task.h"
#import "EditableCell.h"

@interface ListViewController ()

@property (nonatomic, strong) NSMutableArray *toDoTasks;
@property (atomic, readwrite) BOOL isAdd;
@property (nonatomic, strong) EditableCell *currentCell;

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"To Do List";
        self.toDoTasks = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *editableCellNib = [UINib nibWithNibName:@"EditableCell" bundle:nil];
    [self.tableView registerNib:editableCellNib forCellReuseIdentifier:@"EditableCell"];
    
    self.tableView.dataSource = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) editButtonPressed {
    NSLog(@"Inside editButtonPressed method");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditingTable)];
    
    self.navigationItem.rightBarButtonItem = nil;
    
    self.tableView.editing = YES;
}

- (void) doneEditingTable {
    NSLog(@"Inside doneEditingTable method");

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    
    self.tableView.editing = NO;
}

- (void) addButtonPressed {
    NSLog(@"Inside addButtonPressed method");
    
    self.isAdd = YES;
    [self.toDoTasks insertObject:[[Task alloc] initWithToDoTask:@""] atIndex:0];

    self.navigationItem.leftBarButtonItem = nil;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTextFieldEditing)];
    
    [self.tableView reloadData];
}

- (void) doneTextFieldEditing {
    NSLog(@"Inside doneTextFieldEditing method");
    
    self.isAdd = NO;
    
    [self.toDoTasks replaceObjectAtIndex:0 withObject:[[Task alloc] initWithToDoTask:[[self.currentCell textField] text]]];
    
    [[self.currentCell textField] setEnabled:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.toDoTasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditableCell"];
    
    NSString *currentTaskDescription = [self.toDoTasks[indexPath.row] taskDescription];
    [[cell textField] setText: currentTaskDescription];
    [[cell textField] setEnabled:NO];
    if(self.isAdd == YES && indexPath.row == 0){
        [[cell textField] setEnabled:YES];
        [[cell textField] becomeFirstResponder];
        self.currentCell = cell;
    }
    
    return cell;
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
     return YES;
 }

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         [[self toDoTasks] removeObjectAtIndex:indexPath.row];
         [self.tableView reloadData];
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
         NSLog(@"Inside UITableViewCellEditingStyleInsert");
     }
 }

 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     EditableCell *fromCell = self.toDoTasks[fromIndexPath.row];
     EditableCell *toCell = self.toDoTasks[toIndexPath.row];

     [self.toDoTasks replaceObjectAtIndex:toIndexPath.row withObject:fromCell];
     [self.toDoTasks replaceObjectAtIndex:fromIndexPath.row withObject:toCell];
 }

 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
     return YES;
 }


@end
