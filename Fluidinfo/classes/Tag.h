//
//  Tag.h
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "Fluidinfo.h"
#import "FiClass.h"

@class Namespace;

@interface Tag : FiClass <FiClass>
{
    NSString * name;
    NSUUID * id;
    NSString * path;
    NSString * description;
    BOOL indexed;
}
@property (readwrite, nonatomic, copy) NSString * name;
@property (readwrite, nonatomic, copy) NSUUID * id;
@property (readwrite, nonatomic, copy) NSString * path;
@property (readwrite, nonatomic, copy) NSString * description;
@property (readwrite, nonatomic) BOOL indexed;
+ (id)getWithPath:(NSString *)path andName:(NSString *)name;
+ (id)initWithPath:(NSString *)path andName:(NSString *)name;
@end
