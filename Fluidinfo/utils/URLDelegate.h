//
//  URLDelegate.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/28/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"
#import "FiClass.h"

@interface URLDelegate : NSObject
{
    NSMutableData * receivedData;
    FiClass * completionDelegate;
    BOOL complete;
    NSError * error;
}
@property NSMutableData * receivedData;
@property (nonatomic, readwrite) FiClass * completionDelegate;
@property (nonatomic) BOOL complete;
@property (nonatomic, readwrite, copy) NSError * error;

+ (id) initWithCompletionDelegate:(FiClass *)completionDelegate;

- (id) init;
- (void)doRequest:(NSURLRequest *)request;
- (void)setCompletionDelegate:(FiClass *)completionDelegate;
@end
