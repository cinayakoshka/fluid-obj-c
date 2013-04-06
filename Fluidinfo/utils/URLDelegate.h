//
//  URLDelegate.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/28/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"
#import "FiObject.h"

@interface URLDelegate : NSObject
{
    NSMutableData * receivedData;
    FiObject * completionDelegate;
    BOOL complete;
    NSError * error;
}
@property NSMutableData * receivedData;
@property (nonatomic, readwrite) FiObject * completionDelegate;
@property (nonatomic) BOOL complete;
@property (nonatomic, readwrite, copy) NSError * error;

+ (id) initWithCompletionDelegate:(FiObject *)completionDelegate;

- (id) init;
- (void)doRequest:(NSURLRequest *)request;
- (void)setCompletionDelegate:(FiObject *)completionDelegate;
@end
