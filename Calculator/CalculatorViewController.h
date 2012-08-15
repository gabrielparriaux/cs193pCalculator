//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Gabriel Parriaux on 19.05.12.
//  Copyright (c) 2012 Gymnase de Morges. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;

@property (weak, nonatomic) IBOutlet UILabel *operationsDisplay;

- (IBAction)clear:(id)sender;

@end
