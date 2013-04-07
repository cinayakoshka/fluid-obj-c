//
//  Tag.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "Tag.h"

@implementation Tag
@synthesize name, description, path, id, indexed;
+ (id)initWithPath:(NSString *)path andName:(NSString *)name
{
    Tag * tag = [[Tag alloc] init];
    tag.name = name;
    tag.path = path;
    tag.indexed = false;
    tag.description = @"";
    return tag;
}

+ (id)getWithPath:(NSString *)path andName:(NSString *)name
{
    Tag * tag = [Tag initWithPath:path andName:name];
    [tag get];
    return tag;
}

- (void) get
{
    NSURLRequest * request = [FiRequest getPath:[NSString stringWithFormat:@"%@?returnDescription=true",[self fullPath]]];
    [self callFluidinfo:request andWait:YES andProcess:YES];
}

- (NSString *)fullPath
{
    return [NSString stringWithFormat:@"tags/%@/%@", path, name];
}

- (NSString *)fqpath
{
    return [NSString stringWithFormat:@"tags/%@", path];
}

- (NSData *)postJson
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          description, @"description",
                          [NSNumber numberWithBool:indexed], @"indexed",
                          name, @"name", nil];
    return [NSJSONSerialization dataWithJSONObject:dic options:normal error:nil];
}

- (NSData *)putJson
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          description, @"description", nil];
    return [NSJSONSerialization dataWithJSONObject:dic options:normal error:nil];
}

- (void) handleCompletionOrCancelFrom:(URLDelegate *)delegate
{
    @synchronized(self) {
        [super handleCompletionOrCancelFrom:delegate];
        NSDictionary * dictionary = [super getDictionaryMaybeFrom:delegate];
        [self processReturnedDictionary:dictionary];
    }
}

- (void) processReturnedDictionary:(NSDictionary *)dictionary
{
    [self setId:[dictionary valueForKey:@"id"]];
    description = [dictionary valueForKey:@"description"];
    indexed = (BOOL)[dictionary valueForKey:@"indexed"];
    waiting = NO;
}
@end
