//
//  NSArray+ClockwiseRotation.h
//  Cryptography_1
//
//  Created by Admin on 08.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ClockwiseRotation)
+ (NSArray<NSArray*>*) matrixByRotatingClockwiseMatrix:(NSArray<NSArray*>*)matrix ;
@end

NS_ASSUME_NONNULL_END
