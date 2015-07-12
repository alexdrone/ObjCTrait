//
//  ExampleTarget.m
//  NSTrait
//
//  Created by Alex Usbergo on 8/25/13.
//  Copyright (c) 2013 Alex Usbergo. All rights reserved.
//

#import "ExampleTarget.h"
#import "NSTrait.h"

@implementation ExampleTarget

- (NSString*)name
{
    return @"Alex";
}

+ (void)initialize
{
    [self addTrait:[ExampleTrait class] exclude:nil aliases:nil];
}

- (void)test
{
    [self sayHello];
}

@end
