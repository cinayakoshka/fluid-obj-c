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

}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)waitFor:(FiObject *) obj
{
    NSRunLoop * rl = [NSRunLoop currentRunLoop];
    while (obj.waiting &&
           [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
}

- (void)testNamespaceOps
{
    // create
    Namespace * namespace = [Namespace initWithPath:@"barshirtcliff" andName:@"tests"];
    namespace.description = @"a test namespace.";
    [namespace create];
    [self waitFor:namespace];
    STAssertNotNil(namespace.id, @"Namespace must post to Fi successfully");

    // update & get
    NSString * nd = @"a new description.";
    namespace.description = nd;
    [namespace update];
    [self waitFor:namespace];
    
    Namespace * remoteNamespace = [Namespace initWithPath:@"barshirtcliff" andName:@"tests"];
    [remoteNamespace get];
    [self waitFor:remoteNamespace];
    STAssertTrue([nd isEqualToString:remoteNamespace.description], @"must be able to update a description on a namespace.");
    
    // delete
    [namespace delete];
    [self waitFor:namespace];
    STAssertNil(namespace.id, @"deleted namespace should have no id.");
}
@end

