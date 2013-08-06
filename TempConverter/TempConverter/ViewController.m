//
//  ViewController.m
//  TempConverter
//
//  Created by Pulkit Goel on 8/6/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSNumber *fieldType;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"Temparature";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	self.fahrenheitTempTextField.delegate = self;
    self.celciusTempTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDoneButton{
    [self.view endEditing:YES];
}


- (void)convertTemperature{
    self.errorLabel.text = @"";
    if(self.fieldType.intValue == 1){
        if([self.celciusTempTextField.text length] > 0){
            [self updateFahrenheitTemperature];
        }else if([self.fahrenheitTempTextField.text length] > 0){
            [self updateCelciusTemperature];
        }else{
            [self showErrorMessage];
        }
    }else if(self.fieldType.intValue == 2){
        if([self.fahrenheitTempTextField.text length] > 0){
            [self updateCelciusTemperature];
        }else if([self.celciusTempTextField.text length] > 0){
            [self updateFahrenheitTemperature];
        }else {
            [self showErrorMessage];
        }
    }else{
        [self showErrorMessage];
    }
}

#pragma mark - UITextField delegate methods

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField{
  //  NSLog([NSString stringWithFormat:@"TextField: %s", [textField.text]]);
    if(textField == self.celciusTempTextField){
        NSLog(@"Temperature provided in Celcius");
        self.fieldType = @1;
    }else if(textField == self.fahrenheitTempTextField){
        NSLog(@"Temperature provided in Fahrenheit");
        self.fieldType = @2;
    }
    return YES;
}

#pragma mark - private methods

- (void) updateFahrenheitTemperature{
    NSLog(@"Calculating temperature in Fahrenheit");
    float cTemp = [self.celciusTempTextField.text floatValue];
    float fTemp = cTemp * 9/5 + 32;
    self.fahrenheitTempTextField.text = [NSString stringWithFormat:@"%0.2f",fTemp];
}

- (void) updateCelciusTemperature{
    NSLog(@"Calculating temperature in Celcius");
    float fTemp = [self.fahrenheitTempTextField.text floatValue];
    float cTemp =  (fTemp - 32)*5/9;
    self.celciusTempTextField.text = [NSString stringWithFormat:@"%0.2f",cTemp];
}

- (void) showErrorMessage{
    NSLog(@"Showing error message");
    self.errorLabel.text = @"Please input C/F temparature";
}

@end
