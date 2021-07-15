# LithoOperators

[![CI Status](https://circleci.com/gh/LithoByte/LithoOperators.svg?style=svg)](https://circleci.com/gh/LithoByte/LithoOperators)
[![Version](https://img.shields.io/cocoapods/v/LithoOperators.svg?style=flat)](https://cocoapods.org/pods/LithoOperators)
[![License](https://img.shields.io/cocoapods/l/LithoOperators.svg?style=flat)](https://cocoapods.org/pods/LithoOperators)
[![Platform](https://img.shields.io/cocoapods/p/LithoOperators.svg?style=flat)](https://cocoapods.org/pods/LithoOperators)

## Installation

LithoOperators is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LithoOperators', git: 'https://github.com/LithoByte/LithoOperators'
```

## What's in this pod

This pod provides a bunch of quality-of-life improving functions and operators to make FP in Swift simpler.

### `infix operator >?>`
This operator allows you to chain functions where optionality is an issue. For instance,
suppose you had a function `f` which output a `String?` and another function `g` which only
accepts a `String`; trying to use `f >>> g` would fail to compile, since you can't pass `nil`
to `g`. By using `f >?> g`, however, will compile, since this operator only executes `g` if
`f` returns a non-`nil` value. This is really nice paired with `optionalCast` defined below,
which will try to cast an object for you. So for instance, suppose you had a function `f` from
`(UIButton) -> Void` but wanted to be able to apply it intelligently to any `UIView` passed
in; then you could do `optionalCast >?> f` and the compiler would return a function from
`UIView -> Void` which, if the UIView is a `UIButton` in particular, would apply `f` to it.

### `func optionalCast<T, U>(object: U) -> T?`
This is a really nice function that will cast objects for you. When paired with `>?>` the compiler will
be able to tell what type to cast to without you saying explicitly.

### `infix operator *>`
This is basically an operator for currying. It puts the value `a` into the first postion of a function `f`
from `(A, B) -> C` and returns a function that just accepts a value for `B`. In Prelude this would
be `a |> curry(f)`.

### `infix operator ||>`
Similar to `>|>`, but with the second value. So consider `f: (A, B) -> C`. Then `b ||> f`
will put `b` into the second argument of `f` and return a function from `A -> C`. I find this more
ergonmic than using `curry` in this case, since I don't need to swap the arguments around or anything.
The use case for this is mostly with the free `map` function defined below, so for instance, if you had
a function `f` from `Int -> String` and wanted to use it to change an array of `Int`s to `String`s,
you could do so by saying: `f ||> map` which would return a function from `[Int] -> [String]`

### `infix operator |||>`
See above, convenient currying, but with more arguments.
### `infix operator ||||>`
See above, convenient currying, but with more arguments.
### `infix operator |||||>`
See above, convenient currying, but with more arguments.
### `infix operator ||||||>`
See above, convenient currying, but with more arguments.

### `func voidCurry<T, U>(_ t: T, _ f: @escaping (T) -> U) -> () -> U`
This just returns a function that can be called without arguments at a later time with the passed in value
prepopulated. I often use this when a reusable component shouldn't know the passed in type, but needs
to pass it to other code when an action occurs.

### `infix operator *>`
Operator version of `voidCurry`

### `prefix operator ^`
An operator to create a function that, given a keypath for a type, will a function that will accept
an object of that type and return the object's property's value. So for instance,
`^\UIViewController.view` will return a function `(UIViewController) -> UIView`. This comes from
the excellent [PointFree](https://pointfree.co) videos.

### `func union(_ functions: (() -> Void)...) -> () -> Void`
Here, `union` will take a bunch of functions and return a function that, when called, will
call each of those functions in the bunch. I use this mostly for UI styling, so for instance,
for two functions called `setClipsToBounds` and `setGrayBackground` both of
which are from `UIView -> Void`, then you could create a new function called, say,
`clipAndGrayBg = union(setClipsToBounds, setGrayBackground)`.

### `func coalesceNil<T>(with defaultValue: T) -> (T?) -> T`
This just a function version of the nil coalescing operator `??`

### `func ifExecute<T>(_ t: T?, _ f: (T) -> Void)`
This function executes `f` if the value passed in is non-`nil`. Convenient when you have
a function that accepts only non-optional values, but you have an unwrapped variable. Basically,
this function unwraps optionals for you.

### `infix operator ?>`
This is just an operator version of `ifExecute`.

### `func ifApply(_ condition: Bool, _ function: (Self) -> Self) -> Self`
This is an extension function for a protocol named `ConditionalApply`.  This function passes 
itself to the given function if the condition is true. I don't use it much in iOS, but
it's pretty helpful in Vapor when creating database queries.

### `func firstElement<T>(_ array: [T]) -> T?`
This returns the first element of an array, if that element exists

### `func map<U, V>(array: [U], f: (U) -> V) -> [V]`
A free function version of `map`.

### `func map<Value>(_ kp: KeyPath<Element, Value>) -> [Value]`
This is in an extension of `Sequence` and comes from the excellent [PointFree](https://pointfree.co) videos.
It allows you to transform arrays using keypaths.

### `func compactMap<Value>(_ kp: KeyPath<Element, Value?>) -> [Value]`
Same as the previous, but with `compactMap` as the foundation instead.

### `func map<Element, Value>(array: [Element], _ kp: KeyPath<Element, Value>) -> [Value]`
free function version of `map` with keypaths.

### `func fzip<T, U, V>(_ f: @escaping (T) -> U, _ g: @escaping (T) -> V) -> (T) -> (U, V)`
This function zips together the outputs of some functions into a tuple. Very convenient when creating a view from a single model while
keeping the two decoupled.

This pod also includes the functional getters/setters developed in the [PointFree](https://pointfree.co) videos. 
So `prop`, `get`, `set`, `over`, `mut`, `mver`, and so on. 

## Author

Elliot Schrock

## License

LithoOperators is available under the MIT license. See the LICENSE file for more info.
