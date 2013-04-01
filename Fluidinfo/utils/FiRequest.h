//
//  FiRequest.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/31/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

@interface FiRequest : NSObject
+ (NSURLRequest *) getPath:(NSString *)path;
+ (NSURLRequest *) getName:(NSString *)name withPath:(NSString *)path;
@end
