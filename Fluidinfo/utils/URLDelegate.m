//
//  URLDelegate.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/28/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "URLDelegate.h"

@implementation URLDelegate
@synthesize receivedData, complete, completionDelegate, error;
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

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)_error
{    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [_error localizedDescription],
          [[_error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    self.error = _error;
    [self callback];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    complete = YES;
    [self callback];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)space
{
    NSString *authenticationMethod = space.authenticationMethod;
    if ([authenticationMethod isEqual:NSURLAuthenticationMethodHTTPBasic]) {
        return YES;
    }
    if ([authenticationMethod isEqual:NSURLAuthenticationMethodServerTrust]) {
        return YES;
    }
    
    return NO;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] > 2) {
        return;
    }
    NSString *authenticationMethod = challenge.protectionSpace.authenticationMethod;
    Session *session = [Session get];
    
    if ([authenticationMethod isEqual:NSURLAuthenticationMethodHTTPBasic]) {
        [[challenge sender] useCredential:[session getCredential]
               forAuthenticationChallenge:challenge];
    } else if ([authenticationMethod isEqual:NSURLAuthenticationMethodServerTrust]
               && [challenge.protectionSpace.host isEqualToString:session.fiInstance]) {
    //    NSURLCredential *serverTrust = [NSURLCredential credentialForTrust: challenge.protectionSpace.serverTrust];

        [challenge.sender useCredential:[session getCredential]
             forAuthenticationChallenge: challenge];
    } else {
        // proceed anyway.
        [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}
@end
