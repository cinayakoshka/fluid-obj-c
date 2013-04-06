//
//  FiObject.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>
@class URLDelegate;


@protocol FiClass <NSObject>
@required
- (void)update;
- (void)create;
- (void)delete;
- (void)get;
@end

@interface FiObject : NSObject <FiClass>
{
    BOOL waiting;
    NSError * error;
}
// TODO: add some locking around waiting - avoid simultaneous updates.
@property(readwrite, nonatomic) BOOL waiting;
@property(readwrite, nonatomic, copy) NSError * error;
- (NSString *)fullPath;
- (void)handleCompletionOrCancelFrom:(URLDelegate *)delegate;
- (NSDictionary *)getDictionaryMaybeFrom:(URLDelegate *)delegate;
- (void) callFluidinfo:(NSURLRequest *)request andWait:(BOOL) wait;
@end
