//
//  FluidinfoTests.h
//  FluidinfoTests
//
//  Created by Barbara Shirtcliff on 3/28/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Fluidinfo.h"
#import "Namespace.h"


@interface FluidinfoTests : SenTestCase
{
    Fluidinfo * fluidinfo;
    FiObject * fiObject;
    NSBlockOperation * block;
}
@property (readwrite, copy) Fluidinfo * fluidinfo;
@property (readwrite) FiObject * fiObject;
@property (readwrite) NSBlockOperation * block;
@end
