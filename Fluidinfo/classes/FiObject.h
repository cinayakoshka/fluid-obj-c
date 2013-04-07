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
    BOOL processResponse;
    NSError * error;
}
@property(readwrite, nonatomic) BOOL waiting;
@property(readwrite, nonatomic) BOOL processResponse;
@property(readwrite, nonatomic, copy) NSError * error;
- (void)handleCompletionOrCancelFrom:(URLDelegate *)delegate;
- (NSDictionary *)getDictionaryMaybeFrom:(URLDelegate *)delegate;
- (void) callFluidinfo:(NSURLRequest *)request andWait:(BOOL)wait andProcess:(BOOL)process;

// subclasses must implement these:
- (NSString *)fullPath;
- (NSString *)fqpath;
- (NSData *)postJson;
- (NSData *) putJson;
@end
