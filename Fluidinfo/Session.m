//
//  Session.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/31/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "Session.h"

#define INSTANCE [NSURL URLWithString: [NSString stringWithFormat:@"%@://%@", scheme, instance]]
#define __DEBUG__ YES

@implementation Session
@synthesize instance, scheme, port, credential;

static Session * session;

+ (void) initialize
{
    session = [Session alloc];
    [session setInstance:@"fluiddb.fluidinfo.com"];
    [session setPort:443];
    [session setScheme:@"http"];
}

+ (id) get
{
    return session;
}

+ (void) setUsername:(NSString *)u andPassword:(NSString *)p
{
    [session setCredential:[NSURLCredential credentialWithUser:u password:p persistence:NSURLCredentialPersistencePermanent]];
}

- (NSURLCredential *) getCredential
{
    return credential;
}

- (NSURL *) getInstance
{
    return INSTANCE;
}

+ (NSURL *) urlForPath:(NSString *)path
{
    return [NSURL URLWithString:path relativeToURL:[[Session get] getInstance]];
}

@end
