//
//  FluidinfoTests.m
//  FluidinfoTests
//
//  Created by Barbara Shirtcliff on 3/28/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "FluidinfoTests.h"

@implementation FluidinfoTests
@synthesize fluidinfo, fiObject, block;

- (void)setUp
{
    [super setUp];
    fluidinfo = [[Fluidinfo alloc] initWithUsername:@"barshirtcliff" andPassword:@"for)+ut"];

}

- (void)tearDown
{
    
    NSRunLoop * rl = [NSRunLoop currentRunLoop];
    while (fiObject.waiting > 0 &&
           [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    [block start];
    // Tear-down code here.
    [super tearDown];
}

- (void)testNamespaceCreate
{
    Namespace * namespace = [Namespace initWithPath:@"barshirtcliff" andName:@"tests"];
    namespace.description = @"a test namespace.";
    fiObject = namespace;
    block = [NSBlockOperation blockOperationWithBlock:^{
        STAssertNotNil(namespace.id, @"Namespace must post to Fi successfully");
    }];
    [namespace create];
}

- (void)testNamespaceDelete
{
    Namespace * namespace = [Namespace initWithPath:@"barshirtcliff" andName:@"tests"];
    fiObject = namespace;
    block = [NSBlockOperation blockOperationWithBlock:^{
        STAssertNil(namespace.id, @"deleted namespace should have no id.");
    }];
    [namespace delete];
}
@end




/*
- (void)testNamespaceGet
{
    Namespace * namespace = [Namespace getWithPath:NULL andName:@"barshirtcliff"];
    NSRunLoop * rl = [NSRunLoop currentRunLoop];
    
    while ([namespace waiting] &&
           [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    NSLog(@"got namespace: %@", namespace);
}

- (void)testPrivateNamespaceGet
{
    Namespace * namespace = [Namespace getWithPath:@"barshirtcliff" andName:@"private"];
    NSRunLoop * rl = [NSRunLoop currentRunLoop];
    
    while ([namespace waiting] &&
           [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    NSLog(@"got namespace: %@", namespace);
}
*/


