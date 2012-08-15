//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Gabriel Parriaux on 19.05.12.
//  Copyright (c) 2012 Gymnase de Morges. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize operationsDisplay = _operationsDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
        return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) {
//        empecher l'utilisateur de rentrer deux points dans un meme nombre
        NSRange range = [self.display.text rangeOfString:@"."];
        if (range.location != NSNotFound && [digit isEqualToString:@"."]) {
            self.display.text = self.display.text;
        } else {
            self.display.text = [self.display.text stringByAppendingString:digit];
        }
    } else {
//        prendre en consideration le cas ou l'utilisateur commence par entrer un point
        if ([digit isEqualToString:@"."]) {
            self.display.text = @"0.";
        } else {
            self.display.text = digit;
        }
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }

}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
//    ajouter nombre dans la ligne du calcul
    self.operationsDisplay.text = [self.operationsDisplay.text stringByAppendingString:[self.display.text stringByAppendingString:@" "]];
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
//    ajouter operateur dans la ligne du calcul
    NSString *digitForOperationDisplay = [sender currentTitle];
    self.operationsDisplay.text = [self.operationsDisplay.text stringByAppendingString:[digitForOperationDisplay stringByAppendingString:@" "]];
}


- (void)viewDidUnload {
    [self setOperationsDisplay:nil];
    [super viewDidUnload];
}

- (IBAction)clear:(id)sender {
    
    self.display.text = @"";
    self.operationsDisplay.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain empty];
    
}
@end
