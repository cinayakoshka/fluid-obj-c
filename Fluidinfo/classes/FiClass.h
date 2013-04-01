//
//  FiClass.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FiClass <NSObject>
@required
- (BOOL)update;
- (BOOL)create;
- (BOOL)delete;

@optional
- (BOOL)get;
@end
