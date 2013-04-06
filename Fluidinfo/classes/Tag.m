//
//  Tag.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "Tag.h"

@implementation Tag
@synthesize name, description, namespace, id, indexed;
+ (id) initWithNamespace:(Namespace *)namespace andName:(NSString *)name
{
    Tag * tag = [[Tag alloc] init];
    tag.name = name;
    tag.namespace = namespace;
    tag.indexed = false;
    return tag;
}

+ (id) getWithNamespace:(Namespace *)namespace andName:(NSString *)name
{
    Tag * tag = [Tag initWithNamespace:namespace andName:name];
    [tag get];
    return tag;
}

- (void) get
{
    NSURLRequest * request = [FiRequest getPath:[NSString stringWithFormat:@"%@/%@", namespace.path, name]];
    [self callFluidinfo:request andWait:YES];
}

- (void) update
{

}

- (void) create
{

}

- (void) delete
{

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
