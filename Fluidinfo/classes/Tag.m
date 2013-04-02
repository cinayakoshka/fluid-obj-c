//
//  Tag.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "Tag.h"

@implementation Tag
@synthesize name, description, namespace, id;
+ (id) initWithNamespace:(Namespace *)namespace andName:(NSString *)name
{
    Tag * tag = [[Tag alloc] init];
    tag.name = name;
    tag.namespace = namespace;
    return tag;
}

+ (id) getWithNamespace:(Namespace *)namespace andName:(NSString *)name
{
    Tag * tag = [Tag initWithNamespace:namespace andName:name];
    [tag get];
    return tag;
}

- (BOOL) get
{
    @synchronized(self) {
        waiting = YES;
        URLDelegate * d = [URLDelegate initWithCompletionDelegate:self];
        NSURLRequest * request = [FiRequest getName:name withPath:namespace.path];
        [d doRequest:request];
    }
    return YES;
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

- (void) handleCompletionOrCancelFrom:(URLDelegate *)delegate
{
    @synchronized(self) {
        NSDictionary * dictionary = [super getDictionaryMaybeFrom:delegate];
        [self processReturnedDictionary:dictionary];
    }
}

- (void) processReturnedDictionary:(NSDictionary *)dictionary
{
    [self setId:[dictionary valueForKey:@"id"]];
    description = [dictionary valueForKey:@"description"];
    waiting = NO;
}
@end
