//
//  Fluidinfo.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/31/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fluidinfo.h"
#import "Session.h"
#import "FiRequest.h"
#import "FiObject.h"
#import "URLDelegate.h"
#import "Namespace.h"
#import "Tag.h"

@interface Fluidinfo : NSObject
- (id) initWithUsername:(NSString *)u andPassword:(NSString *)p;
- (id) init;
@end
