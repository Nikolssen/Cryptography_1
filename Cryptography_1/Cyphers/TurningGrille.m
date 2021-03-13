//
//  TurningGrille.m
//  Cryptography_1
//
//  Created by Admin on 08.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import "TurningGrille.h"
#import "NSArray+ClockwiseRotation.h"
#import "NSString+RandomString.h"
@implementation TurningGrille
- (NSString*) cypher:(NSString *)message{
    NSString* filteredMessage = [[message stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    unsigned long size = (NSUInteger) ceil(sqrt(filteredMessage.length));
    if (size % 2 == 1)
        size++;
    
    unsigned long submatrixSize = size / 2;
    NSMutableArray<NSMutableArray*>* firstSubmatrix = [NSMutableArray new];
    NSMutableSet *set = [NSMutableSet new];
    for (unsigned int i = 0; i<submatrixSize; i++) {
        NSMutableArray* array = [NSMutableArray new];
        for (unsigned int j = 0; j<submatrixSize; j++)
        {
            do {
                NSNumber *number = [NSNumber numberWithInt:(arc4random()% (submatrixSize*submatrixSize)+1)];
                if (![set containsObject:number])
                {
                    [array addObject:number];
                    [set addObject:number];
                    break;
                }
            } while (YES);
        }
        [firstSubmatrix addObject:array];
    }
    set = nil;
    
    NSArray* secondSubmatrix = [NSArray matrixByRotatingClockwiseMatrix:firstSubmatrix];
    NSArray* thirdSubmatrix = [NSArray matrixByRotatingClockwiseMatrix:secondSubmatrix];
    NSArray* fourthSubmatrix = [NSArray matrixByRotatingClockwiseMatrix:thirdSubmatrix];
    
    NSMutableArray<NSMutableArray*>* matrix = [NSMutableArray new];

    
    
    for (unsigned i = 0; i<submatrixSize; i++) {
        [matrix addObject: [NSMutableArray new]];
        for (unsigned j = 0; j< submatrixSize; j++){
            [[matrix objectAtIndex:i] addObject:[[firstSubmatrix objectAtIndex:i] objectAtIndex:j]];
        }
        for (unsigned j = 0; j< submatrixSize; j++){
            [[matrix objectAtIndex:i] addObject:[[secondSubmatrix objectAtIndex:i] objectAtIndex:j]];
        }
    }
    for (unsigned i = 0; i<submatrixSize; i++) {
        [matrix addObject: [NSMutableArray new]];
        for (unsigned j = 0; j< submatrixSize; j++){
            [[matrix objectAtIndex:(submatrixSize+i)] addObject:[[fourthSubmatrix objectAtIndex:i] objectAtIndex:j]];
        }
        for (unsigned j = 0; j< submatrixSize; j++){
            [[matrix objectAtIndex:(submatrixSize+i)] addObject:[[thirdSubmatrix objectAtIndex:i] objectAtIndex:j]];
        }
    }
    firstSubmatrix = nil;
    secondSubmatrix = nil;
    thirdSubmatrix = nil;
    fourthSubmatrix = nil;
    
    int row;
    int column;
    
    for(int i = 1; i<= submatrixSize*submatrixSize;){
        column = arc4random()% size;
        row = arc4random()% size;
        if ([matrix[row][column] intValue] == i)
        {
            matrix[row][column] = @0;
            i++;
            
        }
    }
    NSMutableArray<NSMutableArray<NSMutableString*>*>* resultMatrix = [NSMutableArray new];
    for (int i = 0; i<size; i++) {
        NSMutableArray *line = [NSMutableArray new];
        for (int j = 0; j<size; j++)
            [line addObject:[NSMutableString new]];
        [resultMatrix addObject:line];
    }
    int counter = 0;
    BOOL flag = YES;
    for (int k = 0; k<4 && flag; k++){
        for (int i = 0; i<size && flag; i++){
            for (int j = 0; j< size && flag; j++){
                if ([matrix[i][j] intValue] == 0)
                {
                    [[[resultMatrix objectAtIndex:i] objectAtIndex:j] appendFormat:@"%C", [filteredMessage characterAtIndex: counter]];
                counter++;
                }
                if (counter == filteredMessage.length){
                    flag = NO;
                }
            }
        }
        if (!flag){
        while (k!=4) {
                resultMatrix = [[NSArray matrixByRotatingClockwiseMatrix:resultMatrix] mutableCopy];
            k++;
        }
        }
        else
        resultMatrix = [[NSArray matrixByRotatingClockwiseMatrix:resultMatrix] mutableCopy];
    }
    NSMutableString* result = [NSMutableString new];
    for (NSMutableArray* line in resultMatrix) {
        for (NSMutableString* string in line){
            if ([string isEqualToString:@""])
                [result appendString:[NSString stringFromRandomUppercaseLatinCharactersSized:1]];
            else
            [result appendString:string];
        }
    }

    NSMutableString *key = [NSMutableString new];
    for (int i = 0; i<size; i++){
        for (int j = 0; j<size; j++)
        {
            if ([matrix[i][j] intValue] == 0)
                [key appendString:[NSString stringWithFormat:@"%d", [matrix[i][j] intValue]]];
            else
                [key appendString:@"*"];
        }
       if(i!=size-1)
           [key appendString:@"\n"];
        
    }
    
    _key = key;
    return result;
}
- (NSString*) decypher:(NSString *)cypher withKey:(NSString *)key{
    NSString* filteredKey = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    NSMutableArray* matrix = [NSMutableArray new];
    int size = (int) sqrt(filteredKey.length);
    for (int i = 0; i< size; i++) {
        NSMutableArray* line = [NSMutableArray new];
        for (int j = 0; j< size; j++){
            [line addObject:[NSString stringWithFormat:@"%C", [filteredKey characterAtIndex:(size*i+j)]]];
        }
        [matrix addObject:line];
    }
    
    NSMutableArray* cypherMatrix = [NSMutableArray new];
    for (int i = 0; i< size; i++) {
        NSMutableArray* line = [NSMutableArray new];
        for (int j = 0; j< size; j++){
            [line addObject:[NSString stringWithFormat:@"%C", [cypher characterAtIndex:(size*i+j)]]];
        }
        [cypherMatrix addObject:line];
    }
    NSMutableString* result = [NSMutableString new];
    for (int k = 0; k< 4; k++){
        for (int i = 0; i < size; i++)
            for (int j = 0; j< size; j++){
                if ([matrix[i][j] isEqualToString:@"0"])
                    [result appendString:cypherMatrix[i][j]];
            }
        cypherMatrix = [[NSArray matrixByRotatingClockwiseMatrix:cypherMatrix] mutableCopy];
    }
    return result;
}
@end
