//
//  ResultViewController.m
//  YCab
//
//  Created by Pulkit Goel on 8/14/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import "ResultViewController.h"
#import "DetailResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Sunriver, EGL";
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

- (IBAction) displayRoute{
    DetailResultViewController *detailResultViewController = [[DetailResultViewController alloc] initWithNibName:@"DetailResultViewController" bundle:nil];
    
    [[self navigationController] pushViewController:detailResultViewController animated: YES];
}

@end
