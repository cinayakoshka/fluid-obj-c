//
//  Namespace.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "Namespace.h"

@implementation Namespace
@synthesize path, description, namespaces, tags, id, name;
+ (id) getWithPath:(NSString *)path andName:(NSString *)name
{
    Namespace * namespace = [Namespace initWithPath:path andName:name];
    [namespace get];
    return namespace;
}

+ (id)initWithPath:(NSString *)path andName:(NSString *)name
{
    Namespace * namespace = [[Namespace alloc] init];
    namespace.path = path;
    namespace.name = name;
    return namespace;
}

- (BOOL) get
{
    if (!waiting) {
        if ([lock tryLock]) {
            NSString * fullpath = [NSString stringWithFormat:@"namespaces/%@/%@?returnDescription=false&returnNamespaces=true&returnTags=true", path, name];
            waiting = YES;
            NSURLRequest * request = [FiRequest getPath:fullpath];
            URLDelegate * d = [URLDelegate initWithCompletionDelegate:self];
    
            [d doRequest:request];
            return YES;
        }
    }
    return NO;
}

- (BOOL) update
{
    return NO;
}

- (BOOL) create
{
    return NO;
}

- (BOOL) delete
{
    return NO;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Namespace %@", path];
}

- (void) handleCompletionOrCancelFrom:(URLDelegate *)delegate
{
    NSDictionary * dictionary = [super getDictionaryMaybeFrom:delegate];
    [self processReturnedDictionary:dictionary];
}

- (void) processReturnedDictionary:(NSDictionary *) dictionary
{
    [self setId:[dictionary valueForKey:@"id"]];

    /*
     NSArray * nTags = [dic valueForKey:@"tagNames"];
     if ([tags count] > 0) {
     NSMutableArray * tempTags = [[NSMutableArray alloc] init];
     for (NSString * name in nTags) { // TODO: change to tag objects.
     [tempTags addObject:[Namespace initWithPath:name]];
     }
     tags = [tempTags arrayByAddingObjectsFromArray:tempTags];
     }
     */
    
    NSArray * nNamespaces = [dictionary valueForKey:@"namespaceNames"];
    if ([nNamespaces count] > 0) {
        NSMutableArray * tempNamespaces = [[NSMutableArray alloc] init];
        NSString * tempPath = [NSString stringWithFormat:@"%@/%@", path, name];
        for (NSString * tname in nNamespaces) {
            [tempNamespaces addObject:[Namespace initWithPath:tempPath andName:tname]];
        }
        namespaces = tempNamespaces;
    }
    waiting = NO;
}

@end
