//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Gabriel Parriaux on 19.05.12.
//  Copyright (c) 2012 Gymnase de Morges. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *programStack;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack 
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void)pushOperand:(double)operand 
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}


- (double)performOperation:(NSString *)operation 
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}


- (void)pushVariable:(NSString *)variable
{
    
}


- (id)program
{
        // copy crée une copie du programStack et évite qu'on doive le transmettre comme ça publiquement dans la nature; en plus, il transforme un NSMutableArray en NSArray
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"6+3";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack)[stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"/"]) {
            double diviseur = [self popOperandOffStack:stack];
            double dividende = [self popOperandOffStack:stack];
                //        protéger contre les divisions par 0
                //        if (diviseur == 0) {
                //            result = 0;
                //        } else {
            result = dividende / diviseur;
                //        }
        } else if ([@"-" isEqualToString:operation]) {
            double secondNombre = [self popOperandOffStack:stack];
            double premierNombre = [self popOperandOffStack:stack];
            result = premierNombre - secondNombre;
        } else if ([@"sin" isEqualToString:operation]) {
            result = sin([self popOperandOffStack:stack]*M_PI/180);
        } else if ([@"cos" isEqualToString:operation]) {
            result = cos([self popOperandOffStack:stack]*M_PI/180);
        } else if ([@"√" isEqualToString:operation]) {
            result = sqrt([self popOperandOffStack:stack]);
        } else if ([@"π" isEqualToString:operation]) {
            result = M_PI;
        }

    }
    
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"stack = %@", self.programStack];
}

- (void)empty
{
    [self.programStack removeAllObjects];
}


@end
