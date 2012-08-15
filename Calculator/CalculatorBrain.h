//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Gabriel Parriaux on 19.05.12.
//  Copyright (c) 2012 Gymnase de Morges. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorBrain : UIView

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)empty;


@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
