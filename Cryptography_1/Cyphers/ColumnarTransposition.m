//
//  ColumnarTransposition.m
//  Cryptography_1
//
//  Created by Admin on 07.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import "ColumnarTransposition.h"
#import "NSString+RandomString.h"
@interface ColumnarTransposition()
@property (nonatomic, copy) NSArray<NSNumber*>* headerMatrix;
@end
@implementation ColumnarTransposition

-(instancetype) initWithKey:(NSString *)key{
    
    self = [super init];
    if (self){
        [self getMatrix: [[key stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString]];
    }
    return self;
}

- (void) getMatrix: (NSString*) key{
    
    NSMutableArray<NSNumber*>* matrix = [NSMutableArray new];
    
    NSMutableArray* arr = [NSMutableArray new];
    NSMutableSet* seenCharacters = [NSMutableSet new];
    
    [key enumerateSubstringsInRange:NSMakeRange(0,key.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if (![seenCharacters containsObject:substring])
        {
            [seenCharacters addObject:substring];
            [arr addObject:substring];
        }
    }];
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    NSArray *sortedArray = [NSArray new];
    sortedArray = [arr sortedArrayUsingDescriptors:@[sd]];
    
    for (int i = 0; i<arr.count; i++){
        for (int j = 0; j<arr.count;j++){
            if ([arr[i] isEqualToString:sortedArray[j]]){
                [matrix addObject:[NSNumber numberWithInt:j]];
                break;
            }
        }
    }
    
    
    self.headerMatrix = matrix;
    NSLog(@"%@", self.headerMatrix);
}

- (NSString*) cypher: (NSString*) message{
    NSMutableArray<NSString*>* strings = [NSMutableArray new];
    NSString* filteredMessage = [[message stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    for (unsigned int i = 0; i<filteredMessage.length; i+=self.headerMatrix.count) {
        if (i+self.headerMatrix.count >= filteredMessage.length){
            NSMutableString *str = [NSMutableString new];
            [str appendString:[filteredMessage substringFromIndex:i]];
            [str appendString:[NSString stringFromRandomUppercaseLatinCharactersSized:(self.headerMatrix.count - str.length)]];
            [strings addObject: [NSString stringWithString:str]];
        }
        else
            [strings addObject:[filteredMessage substringWithRange:NSMakeRange(i, self.headerMatrix.count)]];
    }
    
    NSMutableArray<NSMutableString*>* resultStrings = [NSMutableArray new];
    for(int i = 0; i<self.headerMatrix.count; i++){
        [resultStrings addObject:[NSMutableString new]];
        for (NSString* enumedString in strings) {
            [[resultStrings objectAtIndex:i] appendFormat:@"%C", [enumedString characterAtIndex:i]];
        }
    }
    NSMutableString *result = [NSMutableString new];
    for (int i = 0; i<self.headerMatrix.count; i++){
        [result appendString:[resultStrings objectAtIndex: [[self.headerMatrix objectAtIndex:i] intValue]]];
        [result appendString:@" "];
    }

    return result;
}
- (NSString*) decypher:(NSString*) cypher{
    NSString* filteredCypher = [[cypher stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    
    NSMutableArray<NSString*>* strings = [NSMutableArray new];
    unsigned long length = (long) ceil(filteredCypher.length/ (float) self.headerMatrix.count);
    for (int i=0; i<filteredCypher.length; i+=length){
        if (i+self.headerMatrix.count >= filteredCypher.length)
            [strings addObject: [filteredCypher substringFromIndex:i]];
        else
            [strings addObject:[filteredCypher substringWithRange:NSMakeRange(i, length)]];
    }
    NSMutableString* result = [NSMutableString new];
    
    for (unsigned int i =0; i< strings.firstObject.length; i++) {
        for (NSNumber * number in self.headerMatrix) {
            if ([strings objectAtIndex: number.intValue].length > i)
            [result appendString: [[strings objectAtIndex: number.intValue] substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return result;
}





@end
