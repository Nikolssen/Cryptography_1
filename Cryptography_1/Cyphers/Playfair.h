//
//  Playfair.h
//  Cryptography_1
//
//  Created by Admin on 05.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Playfair : NSObject
- (instancetype) initWithKey:(NSString*)key;
- (NSString*) cypher: (NSString*) message;
- (NSString*) decypher:(NSString*) cypher;
@end

NS_ASSUME_NONNULL_END
