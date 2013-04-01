//
//  Fluidinfo.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/31/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "Fluidinfo.h"

@implementation Fluidinfo
- (id) init
{
    self = [super init];
    return self;
}

- (id) initWithUsername:(NSString *)u andPassword:(NSString *)p
{
    self = [super init];
    if (self) {
        [Session setUsername:u andPassword:p];
    }
    return self;
}

- (void) setUsername:(NSString *)u andPassword:(NSString *)p
{
    [Session setUsername:u andPassword:p];
}

@end
