//
//  NSArray+ClockwiseRotation.m
//  Cryptography_1
//
//  Created by Admin on 08.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import "NSArray+ClockwiseRotation.h"

@implementation NSArray (ClockwiseRotation)

+ (NSArray<NSArray *> *)matrixByRotatingClockwiseMatrix:(NSArray<NSArray *> *)matrix{
    unsigned long side = matrix.count;
    NSMutableArray* result = [NSMutableArray new];
    for (unsigned long i = 0; i < side; i++) {
        NSMutableArray *line = [NSMutableArray new];
        for (unsigned long j = 0; j < side; j++)
            [line addObject:[[matrix objectAtIndex:(side - j - 1)] objectAtIndex:i]];
        [result addObject:line];
    }
    return result;
}
@end
