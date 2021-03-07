//
//  NSString+RandomString.m
//  Cryptography_1
//
//  Created by Admin on 07.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import "NSString+RandomString.h"


@implementation NSString (RandomString)
+ (NSString*) stringFromRandomUppercaseLatinCharactersSized: (NSUInteger) length{
    NSString* letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString new];
    for (int i = 0; i<length; i++)
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    return randomString;
}
@end
