//
//  CryptoppHash.h
//  Cryptopp-for-iOS
//
//  Created by TAKEDA hiroyuki(aka @3ign0n) on 11/12/23.
//  Copyright (c) 2011年 All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CryptoppHashFunction
- (NSData*)getHashValue:(NSData*)data;
@end

@interface CryptoppMD5 : NSObject<CryptoppHashFunction> {
}
@end

typedef enum {
    CryptppSHALength1,
    CryptppSHALength256,
    CryptppSHALength512,
} CryptppSHALength;

@interface CryptoppSHA : NSObject<CryptoppHashFunction> {
}
@property (nonatomic, assign, readonly) NSInteger length;

- (id)initWithLength:(CryptppSHALength)length;
@end
