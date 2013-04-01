//
//  URLDelegate.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/28/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "URLDelegate.h"

@implementation URLDelegate
@synthesize receivedData, complete, completionDelegate;
- (id) init
{
    self = [super init];
    if (self) {
        complete = NO;
        completionDelegate = NULL;
    }
    return self;
}

+ (id) initWithCompletionDelegate:(FiObject *)completionDelegate
{
    URLDelegate * delegate = [[URLDelegate alloc] init];
    [delegate setCompletionDelegate:completionDelegate];
    return delegate;
}

- (void)doRequest:(NSURLRequest *)request
{
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if (connection) {
        receivedData = [NSMutableData data];
    } else {
        NSLog(@"connection failed.");
        [self callback];
    }
}

- (void)callback
{
    if (completionDelegate != NULL) {
        [completionDelegate handleCompletionOrCancelFrom:self];
    }
}

# pragma private methods

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)space
{
    if ([[space authenticationMethod] isEqual:NSURLAuthenticationMethodHTTPBasic]) {
        return YES;
    }
    return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    [self callback];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    complete = YES;
    [self callback];
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0) {
        Session * session = [Session get];
        [[challenge sender] useCredential:[session getCredential]
               forAuthenticationChallenge:challenge];
    } else {
        // proceed anyway.
        [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}


@end
