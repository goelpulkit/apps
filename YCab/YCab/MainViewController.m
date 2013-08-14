//
//  MainViewController.m
//  YCab
//
//  Created by Pulkit Goel on 8/14/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import "MainViewController.h"
#import "ResultViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Y! Cab";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) findRoutes{
    ResultViewController *resultViewController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
    
    [[self navigationController] pushViewController:resultViewController animated: YES];
}

@end
