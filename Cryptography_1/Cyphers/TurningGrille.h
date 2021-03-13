//
//  TurningGrille.h
//  Cryptography_1
//
//  Created by Admin on 08.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TurningGrille : NSObject
- (NSString*) cypher: (NSString*) message;
- (NSString*) decypher: (NSString*) cypher withKey: (NSString*) key;
@property (nonatomic, copy, readonly) NSString* key;
@end

NS_ASSUME_NONNULL_END
