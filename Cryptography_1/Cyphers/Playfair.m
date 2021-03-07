//
//  Playfair.m
//  Cryptography_1
//
//  Created by Admin on 05.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import "Playfair.h"
@interface Playfair()
@property(nonatomic, copy) NSString* key;
@property(nonatomic, copy) NSArray<NSArray*>* matrix;
@end

@implementation Playfair

-(instancetype) initWithKey:(NSString *)key{
    
    self = [super init];
    if (self){
        _key = key;
        [self getMatrix];
    }
    return self;
}

- (void) getMatrix{
   
    NSMutableString *table = [NSMutableString stringWithString:[self.key uppercaseString]];
    
    for (unsigned i = 0; i< [table length]; i++){
        if ([table characterAtIndex:i] == 'J'){
            [table replaceCharactersInRange:NSMakeRange(i, 1) withString:@"I"];
        }
    }
    [table appendString:@"ABCDEFGHIKLMNOPQRSTUVWXYZ"];
    NSMutableSet *seenCharacters = [NSMutableSet set];
    NSMutableString *result = [NSMutableString string];
    [table enumerateSubstringsInRange:NSMakeRange(0, [table length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if (![seenCharacters containsObject:substring]){
            [seenCharacters addObject:substring];
            [result appendString:substring];
        }
    }];
    
   
    NSMutableArray* resultMatrix = [NSMutableArray new];
    for (int i = 0; i<5; i++){
         NSMutableArray* resultArray = [NSMutableArray new];
        for (int j = 0; j<5; j++){
            [resultArray addObject: [NSString stringWithFormat:@"%c", [result characterAtIndex:(i*5+j)]]];
        }
        [resultMatrix addObject:resultArray];
    }
    NSLog(@"%@", resultMatrix);
    self.matrix = resultMatrix;
}

- (NSString*) biCodeForCharacters:(NSString*) string ToCypher:(BOOL) shouldCypher{
    
    struct{
        int i;
        int j;
    } char1, char2;
    
    for (int i=0; i<5; i++){
        for (int j = 0; j<5; j++){
            if ([string characterAtIndex:0] == [[[self.matrix objectAtIndex:i] objectAtIndex:j] characterAtIndex:0]){
                char1.i = i;
                char1.j = j;
            }
        if ([string characterAtIndex:1] == [[[self.matrix objectAtIndex:i] objectAtIndex:j] characterAtIndex:0]){
            char2.i = i;
            char2.j = j;
        }
            
        }
    }
    NSMutableString *result = [NSMutableString new];
    if (char1.i == char2.i){
        int j;
        
        if (shouldCypher)
            j = (char1.j < 4) ? (char1.j +1) : 0;
        else
            j = (char1.j > 0) ? (char1.j -1) : 4;
        
        [result appendString:[[self.matrix objectAtIndex:char1.i] objectAtIndex:j]];
        if (shouldCypher)
            j = (char2.j < 4) ? (char2.j +1) : 0;
        else
            j = (char2.j > 0) ? (char2.j -1) : 4;
        
        [result appendString:[[self.matrix objectAtIndex:char2.i] objectAtIndex:j]];
        return result;
    }
    if (char1.j == char2.j){
        int i;
        
        if (shouldCypher)
            i = (char1.i < 4) ? (char1.i +1) : 0;
        else
            i = (char1.i > 0) ? (char1.i -1) : 4;
        
        [result appendString:[[self.matrix objectAtIndex:i] objectAtIndex:char1.j]];
        
        if (shouldCypher)
            i = (char2.i < 4) ? (char2.i +1) : 0;
        else
            i = (char2.i > 0) ? (char2.i -1) : 4;
        
        [result appendString:[[self.matrix objectAtIndex:i] objectAtIndex:char2.j]];
        return result;
    }
    else {
        [result appendString:[[self.matrix objectAtIndex:char1.i]objectAtIndex:char2.j]];
        [result appendString:[[self.matrix objectAtIndex:char2.i]objectAtIndex:char1.j]];
        return result;
    }
  
    
    
}

- (NSString*) cypher:(NSString *)message{
    
    NSMutableString* result = [NSMutableString new];
    NSString *newMessage = [[[[message stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString]stringByReplacingOccurrencesOfString:@"J" withString:@"I"] uppercaseString];

    int i = 0;
    while(i< newMessage.length){
        if (i+1 == newMessage.length)
        {
            [result appendString:[self biCodeForCharacters:[NSString stringWithFormat:@"%cX", [newMessage characterAtIndex:i]]ToCypher:YES]];
            i++;
            continue;
        }
        if ([newMessage characterAtIndex:i] ==[newMessage characterAtIndex:i+1]){
            [result appendString:[self biCodeForCharacters:[NSString stringWithFormat:@"%cX", [newMessage characterAtIndex:i]]ToCypher:YES]];
            i++;
            continue;
        }
        else {
            [result appendString:[self biCodeForCharacters:[newMessage substringWithRange:NSMakeRange(i, 2)] ToCypher:YES]];
            i+=2;
        }
    }
    return result;
}


- (NSString*) decypher:(NSString *)cypher{
    NSMutableString* result = [NSMutableString new];
    NSString *newMessage = [[[[cypher stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString]stringByReplacingOccurrencesOfString:@"J" withString:@"I"] uppercaseString];

    int i = 0;
    while(i< newMessage.length){
        
            [result appendString:[self biCodeForCharacters:[newMessage substringWithRange:NSMakeRange(i, 2)] ToCypher:NO]];
            i+=2;
        
    }
    return [result stringByReplacingOccurrencesOfString:@"X" withString:@"(X)"];
}
@end
