//
//  ViewController.h
//  TempConverter
//
//  Created by Pulkit Goel on 8/6/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>


@property (nonatomic, strong) IBOutlet UITextField *fahrenheitTempTextField;
@property (nonatomic, strong) IBOutlet UITextField *celciusTempTextField;
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, strong) IBOutlet UILabel *errorLabel;

- (IBAction) onDoneButton;
- (IBAction) convertTemperature;

@end
