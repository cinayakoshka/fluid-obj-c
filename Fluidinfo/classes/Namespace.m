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
    namespace.description = @"";
    return namespace;
}

- (NSData *)postJson
{
    NSDictionary * temp = [NSDictionary dictionaryWithObjectsAndKeys:
                           description, @"description",
                           name, @"name", nil];
    return [NSJSONSerialization dataWithJSONObject:temp options:noErr error:nil];
}

- (NSData *) putJson
{
    
    NSDictionary * temp = [NSDictionary dictionaryWithObjectsAndKeys:
                           description, @"description", nil];
    return [NSJSONSerialization dataWithJSONObject:temp options:normal error:nil];
}

- (void) get
{
    NSURLRequest * request = [FiRequest getPath:[NSString stringWithFormat:@"%@?returnDescription=true&returnNamespaces=true&returnTags=true",[self fullPath]]];
    [self callFluidinfo:request andWait:YES];
}

- (NSString *)fqpath
{
    return [NSString stringWithFormat:@"namespaces/%@", path];
}

- (NSString *) fullPath
{
    if (path != NULL)
        return [NSString stringWithFormat:@"namespaces/%@/%@", path, name];
    else
        return [NSString stringWithFormat:@"namespaces/%@", name];
}

- (void) handleCompletionOrCancelFrom:(URLDelegate *)delegate
{
    @synchronized(self) {
        [super handleCompletionOrCancelFrom: delegate];
        if (delegate.complete) {
            NSDictionary * dictionary = [super getDictionaryMaybeFrom:delegate];
            [self processReturnedDictionary:dictionary];
        }
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
            [tempNamespaces addObject:
             [Namespace initWithPath:[NSString stringWithFormat:@"%@/%@", path, name] andName:tname]];
        }
        namespaces = tempNamespaces;
    }
    waiting = NO;
}

@end
