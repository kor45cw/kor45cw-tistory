# Functional Swift: Closures { }

- [출처](https://medium.com/swift-india/functional-swift-closures-67459b812d0)


Closures can capture and store references to any constants and variables from the context in which they are defined, known as closing over hence Closure. You can think of a closure as being a function that doesn’t have a name of its own and captures any values from its environment. Functions and closures are first-class objects in Swift: you can store them, pass them as arguments to functions, and treat them as you would any other value or object. Passing closures as completion handlers is a common pattern in many APIs. Standard Swift library uses closures mostly for event handling and callbacks.


What’s Function?
Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed. You define a function with the func keyword. Functions can take none to many parameters, variadic parameters and return none or multiple parameters.


Function Types
Function type is made up of the parameter types and the return type of the function. For above example, function type is:(Int, Int) -> Int
This can be read as: “A function that has two parameters, both of type Int and that returns a value of type Int.” Function type can be set as parameter or return type of function.
Function types can be assign to any variable like this:

```swift
var mathFunction: (Int, Int) -> Int = add
```

Functions are a special cases of closures. Closures take one of three forms:
Global functions: They have a name and can’t capture value.
Nested functions: They have a name and can capture values from their enclosing function.
Closure expressions: They don’t have name and can capture values from their surrounding context.

## Closure Expression:

Closure can be created by putting a function type inside curly braces and in keyword after the return type.

```swift
//: Playground - Closures
// Closure take no parameter and return nothing
let sayHello: () -> Void = {
    print("Hello")
}

sayHello()

// Closure take one parameter and return 1 parameter
let value: (Int) -> Int = { (value1) in
    return value1
}

print(value(5))

// Closure take two parameter and return 1 parameter
let add: (Int, Int) -> Int = { (value1, value2) in
    return value1 + value2
}

print(add(5, 4))

// Closure take two parameter and return String parameter
let addValues: (Int, Int) -> String = { (value1, value2) -> String in
    return String("Sum is: \(value1 + value2)")
}

print(addValues(5, 4))
```

##Shorthand Argument Names
Closure arguments can refer to a position i.e. $0 , $1, $2, $3 and so on.

##Implicit Returns from Closure:
Single-expression closures can implicitly return the result of their single expression by omitting the return keyword from their declaration.

For a multiline expression closure, return keyword can’t be omitted.


## Trailing Closure:
If you need to pass a closure expression to a function as the function’s last argument and closure expression is too long, it can be written as trailing closure. A trailing closure is written after the function call’s parentheses (), even though it is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the closure as part of the function call.

If closure is the last parameter to a method then swift allows you to write like this 🖕

```swift

let digitsList = [1, 2, 3, 4, 5]

let sum = digitsList.reduce(0) { $0 + $1 }
print(sum)
// prints 15
```

The use of trailing closure syntax neatly encapsulates the closure’s functionality immediately after the function that closure supports, without needing to wrap the entire closure within the reduce(_:) method’s outer parentheses.

##Capturing Values:
A closure can capture constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.
In Swift, the simplest form of a closure that can capture values is a nested function, written within the body of another function. A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```


This makeIncrementer function accepts one argument i.e. Int as input and returns a function type i.e. () -> Int. This means that it returns a function, rather than a simple value. The function it returns has no parameters, and returns an Int value each time it is called.
Here amount is argument, runningTotal is declared as variable and initialized with 0. Nested function incrementer captures amount and runningTotal from surrounding context.
Let’s see makeIncrementer in action:

```swift
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen() // returns a value of 10
incrementByTem() // returns  a value of 20
```

```swift
//: Playground - Closures
import Foundation

class CaptureList: NSObject {
    let digit = 5
    
    override init() {
        super.init()
        
        makeSquareOfValue { [digit] squareDigit in
            print("Square of \(digit) is \(squareDigit)")
        }
    }
    
    func makeSquareOfValue(onCompletion: (Int) -> Void) {
        let squareDigit = digit * digit
        onCompletion(squareDigit)
    }
}

CaptureList()

```

> Note: As an optimization, Swift may instead capture and store a copy of a value if that value is not mutated by a closure, and if the value is not mutated after the closure is created.
Swift also handles all memory management involved in disposing of variables when they are no longer needed.

To get rid of long closure expression in function argument you can use typealias.

```swift
//: Playground - Closures
import Foundation

class CaptureList: NSObject {
    let digit = 5
    typealias onCompletionHandler = (Int) -> Void
    
    override init() {
        super.init()
        
        makeSquareOfValue { [digit] squareDigit in
            print("Square of \(digit) is \(squareDigit)")
        }
    }
    
    func makeSquareOfValue(onCompletion: onCompletionHandler) {
        let squareDigit = digit * digit
        onCompletion(squareDigit)
    }
}

CaptureList()
```

## Non-escaping Closures:
Closure parameters were escaping by default before Swift 3. A closure wouldn’t escape the function body if closure parameters are marked as non-escaping
In Swift 3 it’s been reversed. When you are passing a closure as the function argument, the closure gets execute with the function’s body and returns the compiler back. As the execution ends, the passed closure goes out of scope and have no more existence in memory.

## The Least You Need to Know
>Closure parameters are non-escaping by default, if you wanna escape the closure execution, you have to use @escaping with the closure parameters.

Lifecycle of the non-escaping closure:

 1. Pass the closure as a function argument, during the function call.
 2. Do some work in function and then execute the closure.
 3. Function returns.

Due to better memory management and optimizations, Swift has changed all closures to be non-escaping by default. CaptureList.swift is an example of non-escaping closure.
Note: @non-escaping annotation applies only to function types

## Escaping Closures:
A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. Marking a closure with @escaping means you have to refer to self explicitly within the closure.

Lifecycle of the @escaping closure: 

1. Pass the closure as function argument, during the function call. 
2. Do some additional work in function. 
3. Function execute the closure asynchronously or stored. 
4. Function returns.

Let’s see where closures are by default escaping:

- Variables of function type are implicit escaping
- typealiases are implicit escaping
- Optional closures are implicit escaping

### Common Error:
Assigning non-escaping closure to escaping closure. There are 2 ways to fix this:

- Mark closure as escaping
- Or keep the default @noescape behavior by making the closure optional


## Autoclosures:
Swift’s @autoclosure attribute enables you to define an argument that automatically gets wrapped in a closure. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.
For example, the assert(condition:message:file:line:)function takes an autoclosure for its condition and message parameters; its conditionparameter is evaluated only in debug builds and its message parameter is evaluated only if condition is false.

```swift
func assert(_ expression: @autoclosure () -> Bool,
            _ message: @autoclosure () -> String) {}
```

To use `@autoclosure` with `@escaping` attribute syntax is:

```swift
@autoclosure @escaping () -> Bool
```

## Closures vs Blocks:
“Swift closures and Objective-C blocks are compatible so you can pass Swift closures to Objective-C methods that expect blocks. Swift closures and functions have the same type so you can even pass the name of a Swift function. Closures have similar capture semantics as blocks but differ in one key way: Variables are mutable rather than copied. In other words, the behavior of __block in Objective-C is the default behavior for variables in Swift.”

##Closures vs Delegates:
The solution depends on the problem. Moreover, Apple is shifting its focus to Callback pattern. UIAlertAction is an example of this.


## Conclusion:
Sometimes we use concepts but are not aware of terminology. This post will be useful for both novice and experienced developers. I used @escaping, @non-escaping and @autoclosure many times but was not aware of actual concept. I thought to dig into it and share with everyone.