//
//  FiObject.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>
@class URLDelegate;

@interface FiObject : NSObject
{
    BOOL waiting;
}
// TODO: add some locking around waiting - avoid simultaneous updates.
@property(readwrite, nonatomic) BOOL waiting;
@property(atomic) NSLock * lock;
- (void)handleCompletionOrCancelFrom:(URLDelegate *)delegate;
- (NSDictionary *)getDictionaryMaybeFrom:(URLDelegate *)delegate;
@end
