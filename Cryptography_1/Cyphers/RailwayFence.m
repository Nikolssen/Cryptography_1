//
//  RailwayHedge.m
//  Cryptography_1
//
//  Created by Admin on 05.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import "RailwayFence.h"

@interface RailwayFence()
@property(nonatomic, assign) int rows;
@end

@implementation RailwayFence

- (instancetype) initWithNumberOfRows:(int)rows{
    _rows = rows;
    return self;
}

- (NSString*) cypher:(NSString *)message{
    NSMutableString* result = [NSMutableString new];
    NSString* filteredMessage = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableArray<NSMutableString*>* strings = [NSMutableArray new];
    for (int i = 0; i< self.rows; i++){
        [strings addObject:[NSMutableString new]];
    }
    int period = 2 * (self.rows - 1);
    for (int i = 0; i<filteredMessage.length; i++){
        int row = self.rows - 1 - abs(self.rows - 1 - i % period);
        [[strings objectAtIndex:row] appendString:[filteredMessage substringWithRange:NSMakeRange(i, 1)]];
    }
    for (NSString* str in strings) 
        [result appendString:str];
    
     return result;
}


- (NSString*) decypher:(NSString *)cypher{
    NSMutableString* result = [NSMutableString new];
    NSString* filteredCypher = [cypher stringByReplacingOccurrencesOfString:@" " withString:@""];
    int length[self.rows];
    for (int i = 0; i< self.rows; i++)
        length[i] = 0;
    
    int period = 2 * (self.rows - 1);
    for (int i = 0; i<filteredCypher.length; i++){
        int row = self.rows - 1 - abs(self.rows - 1 - i % period);
        length[row]+=1;
    }
    NSMutableArray<NSMutableString*>* strings = [NSMutableArray new];
        for (int i = 0; i< self.rows; i++)
            [strings addObject:[NSMutableString new]];
        
        unsigned int location = 0;
        for (int i = 0; i<self.rows; i++){
            [[strings objectAtIndex:i] appendString:[filteredCypher substringWithRange:NSMakeRange(location, length[i])]];
            location+=length[i];
        }
        
    int i = 0; //index of cypher
    int j = 0; //index of substring
    BOOL isDescending = YES;
    while(i<filteredCypher.length){
        [result appendFormat:@"%c", [[strings objectAtIndex:j] characterAtIndex:0]];
        [[strings objectAtIndex:j]
         replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
        i++;
        
        if (isDescending){
            j++;
            if (self.rows == j){
                isDescending = NO;
                j-=2;
            }
        }
        else
        {
            j--;
            if (j < 0){
                isDescending = YES;
                j+=2;
            }
        }
    
    }
    return result;
}
@end
