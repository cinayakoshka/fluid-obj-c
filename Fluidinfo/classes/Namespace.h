//
//  Namespace.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fluidinfo.h"

@interface Namespace : FiObject
{
    NSString * path;
    NSUUID * id;
    NSString * description;
    NSArray * tags;
    NSArray * namespaces;
}
@property (nonatomic, readwrite) NSArray * namespaces;
@property (nonatomic, readwrite) NSArray * tags;
@property (nonatomic, readwrite) NSString * path;
@property (nonatomic, readwrite) NSUUID * id;
@property (nonatomic, readwrite) NSString * description;
+ (id)getWithPath:(NSString *)path;
+ (id)initWithPath:(NSString *)path;
@end
