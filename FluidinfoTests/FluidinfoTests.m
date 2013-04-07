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
    fluidinfo = [[Fluidinfo alloc] initWithUsername:@"barshirtcliff" andPassword:@"for)+ut"];
    [super setUp];
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
    Namespace * namespace = [Namespace initWithPath:@"barshirtcliff/tests" andName:@"testnamespace"];
    namespace.description = @"a test namespace.";
    [namespace create];
    [self waitFor:namespace];
    STAssertNotNil(namespace.id, @"Namespace must post to Fi successfully");
    
    // record errors non-destructively
    [namespace create];
    [self waitFor:namespace];
    STAssertNil(namespace.error, @"Creating a namespace twice must save an error.");

    // update & get
    NSString * nd = @"a new description.";
    namespace.description = nd;
    [namespace update];
    [self waitFor:namespace];
    
    Namespace * remoteNamespace = [Namespace initWithPath:@"barshirtcliff/tests" andName:@"testnamespace"];
    [remoteNamespace get];
    [self waitFor:remoteNamespace];
    STAssertTrue([nd isEqualToString:remoteNamespace.description], @"must be able to update a description on a namespace.");
    
    // delete
    [namespace delete];
    [self waitFor:namespace];
    STAssertNil(namespace.id, @"deleted namespace should have no id.");
}

- (void)testTagOps
{
    Tag * tag = [Tag initWithPath:@"barshirtcliff/tests" andName:@"atag"];
    [tag create];
    [self waitFor:tag];
    STAssertNotNil(tag.id, @"must be able to create a tag.");
    STAssertFalse(tag.indexed, @"new tags default to not being indexed.");
    
    tag.description = @"a test tag";
    tag.indexed = YES;
    [tag update];
    [self waitFor:tag];
    
    Tag * newTag = [Tag getWithPath:@"barshirtcliff/tests" andName:@"atag"];
    [newTag get];
    [self waitFor:newTag];
    
    STAssertTrue(newTag.indexed, @"must be able to update a tag to indexed");
    STAssertTrue([newTag.description isEqualToString:@"a test tag"], @"must update a tag description.");
    
    [tag delete];
    [self waitFor:tag];
    STAssertNil(tag.id, @"deleted tags have no id.");
}
@end

