//
//  ExampleTrait.m
//  NSTrait
//
//  Created by Alex Usbergo on 8/25/13.
//  Copyright (c) 2013 Alex Usbergo. All rights reserved.
//

#import "ExampleTrait.h"


@implementation ExampleTrait

+ (Protocol*)requires
{
    return @protocol(ExampleTraitRequires);
}

- (void)sayHello
{
    NSLog(@"Hello %@", self.name);
}

- (void)sayHelloTo:(NSString*)to
{
    NSLog(@"Hello %@, from %@", to, self.name);
}


@end
