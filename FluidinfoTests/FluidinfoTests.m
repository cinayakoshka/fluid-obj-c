//
//  FluidinfoTests.m
//  FluidinfoTests
//
//  Created by Barbara Shirtcliff on 3/28/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "FluidinfoTests.h"

@implementation FluidinfoTests
@synthesize fluidinfo;

- (void)setUp
{
    [super setUp];
    fluidinfo = [[Fluidinfo alloc] initWithUsername:@"barshirtcliff" andPassword:@"for)+ut"];
    // or maybe "teon253Gceu+[hei/nt   h"
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)testNamespaceGet
{
    NSString * name = @"barshirtcliff";
    Namespace * namespace = [Namespace getWithPath:name];
    NSRunLoop * rl = [NSRunLoop currentRunLoop];
    
    while ([namespace waiting] &&
           [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    NSLog(@"got namespace: %@", namespace);
}

- (void)testPrivateNamespaceGet
{
    NSString * name = @"barshirtcliff/private";
    Namespace * namespace = [Namespace getWithPath:name];
    NSRunLoop * rl = [NSRunLoop currentRunLoop];
    
    while ([namespace waiting] &&
           [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    NSLog(@"got namespace: %@", namespace);
}


@end
