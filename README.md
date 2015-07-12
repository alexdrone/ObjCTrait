##objc-trait
==========

A trait is a collection of methods, used as a "simple conceptual model for structuring object-oriented programs" similar to mixins.
Traits provide a simple way to create classes that reuse behavior from software components. An object defined as a trait is created as the composition of methods available  in several other objects, which allows for code reuse from various classes without requiring multiple inheritance. In case of a naming collision, when the composed objects have several methods with the same name, the programmer must explicitly disambiguate which one of those methods will  be used in the trait; thus manually solving the "diamond problem" of repeated inheritance. This is different from other composition methods in object-oriented programming, where conflicting names are automatically resolved by scoping rules. [...] http://en.wikipedia.org/wiki/Trait_(computer_programming)

The only limitations in the implementation of a trait method are 
- Never refer to ivar explicity
- Never make calls to super

##Interface

	@interface NSObject (Trait)

Apply the trait to this class

	+ (void)addTrait:(Class)trait;

Apply the trait to this class, excluding the methods listed in 'excluded'.
It renames the methods with the values provides in 'aliased'.
It raises an exception if the trait application does not succed */
	
	+ (void)addTrait:(Class)trait exclude:(NSSet*)excluded aliases:(NSDictionary*)aliased;

@end

##Example of usage (Define a trait)

####ExampleTrait.h:

	@protocol(ExampleTraitRequires)<NSObject>
	@optional
	@property (readonly) NSString *name;
	@end

Remember to define the methods as @optional in the trait protocol 
if you don't want to redefine the declaration in the target object. 
(This lead to a weaker static typing of course)

	@protocol(ExampleTrait)<NSObject>
	@optional
	- (void)sayHello;
	@end
	
	@interface ExampleTrait : NSTrait<ExampleTrait, ExampleTraitRequires>
	@end

####ExampleTrait.m

	@implementation ExampleTrait

This is just to supress the warnings. It won't be used since the property of the target class will be referenced. 

	@dyanamic name;

The superclass' method 'requires' specifies which protocol defines the 
trait requirements. It's not mandatory if the trait has not requirements.

	+ (Protocol*)requires { return @protocol(ExampleTraitRequires); }

The actual method implementation 

	- (void)sayHello { NSLog(@"Hello %@", self.name); }
	
	@end

####Example of usage (Apply a trait)

	@interface ExampleTarget<ExampleTraitRequires, ExampleTrait>
	@end

	@implementation ExampleTarget
	+ (void)initialize { [self addTrait:ExampleTrait.class] }

The class should implement the property required by the trait

	- (NSString*)name { return @"Alex"; }
	@end

..And voilà. Now is possible to call [- sayHello] on an object of class 
ExampleTarget.

