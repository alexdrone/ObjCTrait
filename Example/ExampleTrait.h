//
//  ExampleTrait.h
//  NSTrait
//
//  Created by Alex Usbergo on 8/25/13.
//  Copyright (c) 2013 Alex Usbergo. All rights reserved.
//

#import "NSTrait.h"

@protocol ExampleTraitRequires <NSObject>

@optional
@property (nonatomic, readonly) NSString *name;

@end

@protocol ExampleTraitImplements <NSObject>

@optional
- (void)sayHello;
- (void)sayHelloTo:(NSString*)to;

@end

@interface ExampleTrait : NSTrait<ExampleTraitRequires, ExampleTraitImplements>

@end
