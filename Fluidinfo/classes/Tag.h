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

@interface Tag : FiObject <FiClass>
{
    NSString * name;
    NSUUID * id;
    Namespace * namespace;
    NSString * description;
    BOOL indexed;
}
@property (readwrite, nonatomic, copy) NSString * name;
@property (readwrite, nonatomic, copy) NSUUID * id;
@property (readwrite, nonatomic, copy) Namespace * namespace;
@property (readwrite, nonatomic, copy) NSString * description;
@property (readwrite, nonatomic) BOOL indexed;

+ (id)getWithNamespace:(Namespace *)namespace andName:(NSString *)name;
+ (id)initWithNamespace:(Namespace *)namespace andName:(NSString *)name;

@end
