//
//  FluidinfoTests.m
//  FluidinfoTests
//
//  Created by Barbara Shirtcliff on 3/28/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "FluidinfoTests.h"

#define _DOMAIN @"com.fluidinfo.api.NSCocoaErrorDomain"

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
    NSString * path = @"namespaces/barshirtcliff?returnDescription=false&returnNamespaces=true&returnTags=true";
    Namespace * namespace = [Namespace getWithPath:path];
    NSRunLoop * rl = [NSRunLoop currentRunLoop];
    
    while ([namespace waiting] &&
           [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    NSLog(@"got namespace: %@", namespace);
}

@end
