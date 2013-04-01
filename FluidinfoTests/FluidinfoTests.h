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
}
@property (readwrite, copy) Fluidinfo * fluidinfo;
@end
