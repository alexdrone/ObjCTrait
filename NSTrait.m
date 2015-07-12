//
//  NSTrait.m
//  NSTrait
//
//  Created by Alex Usbergo on 8/25/13.
//  Copyright (c) 2013 Alex Usbergo. All rights reserved.
//

#import "NSTrait.h"
#import <objc/runtime.h>

@implementation NSObject (Trait)

/* Apply the trait to this class */
+ (void)addTrait:(Class)trait
{
    [self addTrait:trait exclude:nil aliases:nil];
}

/* Apply the trait to this class, excluding the methods listed in 'excluded'.
 * It renames the methods with the values provides in 'aliased'.
 * It raises an exception if the trait application does not succed */
+ (void)addTrait:(Class)trait exclude:(NSSet*)excluded aliases:(NSDictionary*)aliased;
{
    //Checks it the trait is legal
    if (![trait isSubclassOfClass:NSTrait.class])
        [NSException raise:@"IllegalTraitClass"
                    format:@"The trait %@ is not a subclass of NSTrait", trait];
    
    //Checks if the target class is compliant
    if ([trait requires] && ![self conformsToProtocol:[trait requires]])
        [NSException raise:@"IllegalTargetClass"
                    format:@"The target class does not implement %@", [trait requires]];

    
    //Get all the trait class methods
    NSUInteger methodsCount;
    Method *methods = class_copyMethodList(trait, &methodsCount);
    
    for (int i = 0; i < methodsCount; i++) {
        
        Method method = methods[i];
        
        //Get the method name (exclusion)
        NSString *methodName = NSStringFromSelector(method_getName(method));
        if (excluded && [excluded containsObject:methodName]) continue;
    
        //Get the method implementation
        IMP implementation = method_getImplementation(method);
        SEL selector = method_getName(method);
                
        //aliases
        if (aliased && aliased[methodName])
            selector = NSSelectorFromString(aliased[methodName]);

        //Add the method to the targetted class
        class_addMethod(self.class, selector, implementation, method_getTypeEncoding(method));
    }
}

@end


@implementation NSTrait

/* The protocol that define the requirement of this trait, before it'll
 * be injected in a different class */
+ (Protocol*)requires
{    
    return nil;
}


@end
