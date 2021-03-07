//
//  ColumnarTransposition.h
//  Cryptography_1
//
//  Created by Admin on 07.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColumnarTransposition : NSObject
- (instancetype) initWithKey:(NSString*)key;
- (NSString*) cypher: (NSString*) message;
- (NSString*) decypher:(NSString*) cypher;
@end


NS_ASSUME_NONNULL_END
