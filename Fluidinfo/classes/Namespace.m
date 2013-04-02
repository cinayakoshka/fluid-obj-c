//
//  Namespace.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "Namespace.h"

@implementation Namespace
@synthesize path, description, namespaces, tags, id;
+ (id) getWithPath:(NSString *)path
{
    Namespace * namespace = [Namespace initWithPath:path];
    [namespace get];
    return namespace;
}

+ (id)initWithPath:(NSString *)path
{
    Namespace * namespace = [[Namespace alloc] init];
    namespace.path = path;
    return namespace;
}

- (BOOL) get
{
    @synchronized(self) {
        waiting = YES;
        NSURLRequest * request = [FiRequest getPath:[NSString stringWithFormat:@"%@?returnDescription=true&returnNamespaces=true&returnTags=true",[self fullPath]]];
        URLDelegate * d = [URLDelegate initWithCompletionDelegate:self];
    
        [d doRequest:request];
        return YES;
    }
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
    return [NSString stringWithFormat:@"%@ { id: %@, description: %@ namespaces: { %@ } tags: { %@ }}",
            path, id, description, namespaces, tags];
}

- (NSString *) fullPath
{
    return [NSString stringWithFormat:@"namespaces/%@", path];
}

- (void) handleCompletionOrCancelFrom:(URLDelegate *)delegate
{
    @synchronized(self) {
        NSDictionary * dictionary = [super getDictionaryMaybeFrom:delegate];
        [self processReturnedDictionary:dictionary];
    }
}

- (void) processReturnedDictionary:(NSDictionary *) dictionary
{
    [self setId:[dictionary valueForKey:@"id"]];
    [self setDescription:[dictionary valueForKey:@"description"]];

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
        for (NSString * tname in nNamespaces) {
            [tempNamespaces addObject:[Namespace initWithPath:[NSString stringWithFormat:@"%@/%@", path, tname]]];
        }
        namespaces = tempNamespaces;
    }
    waiting = NO;
}

@end
