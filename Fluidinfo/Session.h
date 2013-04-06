//
//  Session.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/31/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Session : NSObject
{
    NSURLCredential * credential;
    NSString * fiInstance;
    NSString * scheme;
    int port;
}
@property (readwrite, nonatomic, copy) NSURLCredential * credential;
@property (readwrite, nonatomic, copy) NSString * fiInstance;
@property (readwrite, nonatomic, copy) NSString * scheme;
@property (readwrite) int port;
+ (void) initialize;
+ (id) get;
+ (void) setUsername:(NSString *)u andPassword:(NSString *)p;
// TODO: find out why @synthesize didn't take care of this:
- (NSURLCredential *) getCredential;
+ (NSURL *) urlForPath:(NSString *)path;
@end
