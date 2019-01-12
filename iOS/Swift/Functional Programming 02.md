# Functional Programming 02

## Functor

- context, value, transform 을 함께 놓고 생각해봐야
- context
	- 어떤 값이 처해있는 상태라 말할 수 있다
	- 즉, 무엇인가 wrapping 되어 있는 값은 일단 functor가 될 자격을 갖추고 있다고 볼 수 있다.
	- 이제, 그 context에 map이라는 transform을 지원하는 함수를 추가하면 비로소 functor가 되는 것이다.


```swift
Optional(2).map { (v: Int) -> Int in
    return v + 3
}
```
- map에 전달된 transform 함수로 unwrap된 값이 들어옴을 볼 수 있다. 그리고 Optional을 return하지 않고 그냥 Int를 return함을 볼 수 있다.
- map은 unwrap 후에 transform 함수를 호출해준다.

- 값이 있는 경우

￼![](images/functor10.png)

- 개인적으로는 요즘 guard let / if let 보다 functor를 적극적으로 사용하는 스타일로 코딩 스타일이 조금 바뀌었다.

- 만일 평소에 작은 단위함수를 만드는데 익숙해져있다면, map을 chaining해서 여러 함수의 조합으로 완성된 다른 동작을 만들어내는게 크게 어려운 일은 아닐 것이다. 마치 unix shell에서 명령어들을 연결해서 쓰는 것 처럼...

###결론
- functor는 어떤 value를 map 함수를 지원하는 context로 쌀 수 있는 어떤 자료형태를 말한다.



## Monad
-  즉, flatMap을 가지는 자료형은 모나드이다.
-  어떤 값을 context에 wrapping할 수 있게 지원해주는 타입이 flatMap을 가지면 monad이다.

![](images/monad5.png)
￼


### monad를 어떻게 활용할 것인가?

- monad는 함수들을 chaning해서 사용할 수 있고, 또 중간에 context에 wrapping된 값이 계속 바뀌게 된다.
- 가장 적절한 활용처는 에러 핸들링이 될 수 있을 것이다.
- 여러 단계를 거쳐 동작하는 로직에서 flatMap이 적절하게 error를 return하게 된다면 그 context가 error 상황을 보관하게 될 것이고(optional의 경우 nil) 그 다음 동작들은 실행되지 않으며 최종 결과 단에서 에러를 핸들링 할 수 있는 여지를 제공해준다.
- 결국 Optional chaining도 동일한 것이다. 중간에 하나라도 nil이 된다면 최종 결과물도 nil이 되지만 중간에 일일이 nil check를 해줄 필요가 없는 강점이 있다.


## Optional

- functor이자 monad이다.
- functor라 함은 어떤 값을 싸고 있는 context인데 map같은 transform을 지원하는 타입이라고 했다. Swift에서는 Optional과 array같은 collection들이 포함된다.
- monad는 어떤 값을 싸고 있는 context인데 flatMap같은 flatten동작을 함께 하는 타입이라고 했다. Swift에서는 Optional과 array같은 collection들이 역시 포함된다.

- 통상적으로는 값의 부재 가능성을 표현해 주기 위해 사용한다. 
	- 하지만 이것은 functor/monad 의 기능을 적극적으로 쓰지 않았을 때는 명쾌하지만
	- 적극적으로 사용하게 되면 조금 더 확장되는 형태로 이해를 해야한다.

	
- Optional을 기준으로 설명하자면,
- 값의 부재 가능성을 유지한 상태로 어떤 연산이 필요하다면 functor를 이용해야 한다.
- 또한, 어떤 동작의 결과로 존재하던 값이 부재 상태로 바뀌는 경우가 발생할 수 있다면 monad를 이용해야 한다.	



### Either
- value가 어떤 context에 따라 존재하게 되는데 상태가 이것이거나 저것인 경우 이다.

```swift
enum Either <R, L> {
	case right(R)
	case left(L)
}
```

- 통상 하나의 변수에 다른 타입을 저장할 일이 없지만
- 특정 경우를 보자

```swift
enum Either<T> {
	case right(T)
	case left(Error)
}
```

#### functor로 만들기

```swift
func map<U>(_ transform: (T) throws -> U) rethrows -> Either<U> {
    switch self {
    case .right(let v):
        return Either<U>.right(try transform(v))
    case .left(let e):
        return Either<U>.left(e)
    }
}
```


#### monad로 만들기

```swift
func flatMap<U>(_ transform: (T) throws -> Either<U>) rethrows -> Either<U> {
    switch self {
    case .right:
        let transformed = try self.map(transform)
        return Either.flatten(transformed)
    case .left(let e):
        return Either<U>.left(e)
    }
}

static func flatten<T>(_ result: Either<Either<T>>) -> Either<T> {
    switch result {
    case .right(let r):
        return r
    case .left(let e):
        return Either<T>.left(e)
    }
}
```

- flatten 에는 중첩된 Either를 벗겨내는 동작이 들어가 있다.



#### 더 편하게 변형시켜보기
- 매 flatMap에서 에러가 발생되면 Either.left(Error)를 return하는 것이 여간 불편하지 않다. 만일 transform에서 Error를 throw하면 바로 Either.left로 바꾸어주려면 다음과 같이 flatMap을 수정한다.

```swift
func flatMap<U>(_ transform: (T) throws -> Either<U>) -> Either<U> {
    switch self {
    case .right:
        do {
            let transformed = try self.map(transform)
            return Either.flatten(transformed)
        } catch let e {
            return Either<U>.left(e)
        }
    case .left(let e):
        return Either<U>.left(e)
    }
}
```

- Either.left를 return하지 않아도 되어서 조금은 더 편해지긴 했지만 여전히 Either를 return해야 해서 불편한 감이 있어서 조금 더 편하게 할 방법을 고민해봤는데 map의 transform이 throw하는 Error를 Either.left로 바꿔 줄 방법이 있으면 좋을 것 같다.

하지만 map을 바로 고치는 것은 functor의 동작을 애매하게 만들기 때문에 emap이라는 별도의 map함수를 추가해보았다.

```swift
func emap<U>(_ transform: (T) throws -> U) -> Either<U> {
    do {
        return try self.map(transform)
    } catch let e {
        return Either<U>.left(e)
    }
}
```

#### 정리

- Optional은 값이 있거나 없을 수 있는 context를 제공한다.
- 여기서 한단계 더 나아가면 값이 A이거나 B인 Either라는 타입을 선언할 수도 있다.
- 대부분의 경우 해당 상황의 용법이 error handling이라 가정하면 값을 가지거나 Error를 가지는 타입으로 제한해서 사용할 수 있다.
- 여기에 map, flatMap을 제공하면 functor/monad로 사용가능해진다.
- flatMap을 연속해서 이용하면 데이터 처리를 chaining해서 error를 handling할 수 있다.
- 목적을 최대한 간결하게 수행할 수 있는 emap이라는 함수를 추가했다.


## Memoization

- 연산된 값을 function level에서 caching 하는 것
- 시간이 많이 걸리는 연산을 반복적으로 사용할 때 사용할 수 있다.
- pure function에 작용하기 쉬움

- cache이므로 메모리를 사용하게 된다.
- 동일한 파라미터를 이용해서 함수를 호출하면 처음에는 계산해서 결과를 돌려주지만 다음 호출부터는 cache된 내용을 돌려주는 형태로 구현하게 된다.

- 전제조건
	- 계산된 결과를 메모리에 저장하기 때문에 caching을 많이 하게 되면 메모리 사용량이 증가한다.
	- 동일한 parameter를 받으면 동일한 결과물을 돌려주는 pure function이어야 한다. (그런 경우가 아니라면 끔찍한 일이 벌어진다.)

	
```swift
struct Classifier {
    
    static func factors(of number: Int) -> [Int] {
        return Array<Int>(1...number).filter {
            number % $0 == 0
        }
    }
    
    static func aliquotSum(_ factors: [Int]) -> Int {
        return factors.reduce(0, +) - factors.last!
    }
    
    static func isPerfect(_ number: Int) -> Bool {
        return self.aliquotSum(self.factors(of: number)) == number
    }

    static func isAbundant(_ number: Int) -> Bool {
        return self.aliquotSum(self.factors(of: number)) > number
    }
    
    static func isDeficient(_ number: Int) -> Bool {
        return self.aliquotSum(self.factors(of: number)) < number
    }
    
}
```	

### Cache를 붙여보자

- 고전적인 방법으로

```swift
struct Classifier {

    static var sumCache: [Int: Int] = [:]
    static var factorsCache: [Int: [Int]] = [:]
    
    static func factors(of number: Int) -> [Int] {
        if let factors = self.factorsCache[number] {
            return factors
        } else {
            self.factorsCache[number] = Array<Int>(1...number).filter {
                number % $0 == 0
            }
        }
        
        return self.factors(of: number)
    }
    
    static func aliquotSum(_ factors: [Int]) -> Int {
        let number = factors.last!
        
        if let sum = self.sumCache[number] {
            return sum
        } else {
            self.sumCache[number] = factors.reduce(0, +) - number
        }

        return self.aliquotSum(factors)
    }
    
    static func isPerfect(_ number: Int) -> Bool {
        return self.aliquotSum(self.factors(of: number)) == number
    }

    static func isAbundant(_ number: Int) -> Bool {
        return self.aliquotSum(self.factors(of: number)) > number
    }
    
    static func isDeficient(_ number: Int) -> Bool {
        return self.aliquotSum(self.factors(of: number)) < number
    }
    
}
```

- 문제점
	- cache를 위해서 원래의 로직이 일정부분 숨어버린다.
	- cache를 처리하기 위해서 비슷한 로직이 두 군데(두군데를 caching하므로) 생겼다.
	- function level의 cache가 아니어서 별도의 변수를 두고 있어야 한다.


#### Memoization구현

```swift
func memoize<T:Hashable, U>(_ f: @escaping (T) -> U) -> (T) -> U {
    var cache = [T:U]()
    
    return { (param : T) -> U in
        guard let result = cache[param] else {
            let result = f(param)
            cache[param] = result
            return result
        }
        
        return result
    }
}
```	

- 최종 구현버전

```swift
struct Classifier {
    
    static func factors(of number: Int) -> [Int] {
        return Array<Int>(1...number).filter {
            number % $0 == 0
        }
    }
    
    static func sumOfFactors(number: Int) -> Int {
        return self.mFactors(number).reduce(0, +) - number
    }
    
    static var mFactors = memoize(Classifier.factors(of:))
    static var mSumOfFactors = memoize(Classifier.sumOfFactors(number:))
    
    static func isPerfect(_ number: Int) -> Bool {
        return self.mSumOfFactors(number) == number
    }

    static func isAbundant(_ number: Int) -> Bool {
        return self.mSumOfFactors(number) > number
    }
    
    static func isDeficient(_ number: Int) -> Bool {
        return self.mSumOfFactors(number) < number
    }
    
}
```


###요약 

- Function level의 caching을 지원하는 것을 memoization이라 한다.
- memoize는 function compsition같은 meta function programming으로 구현 가능하다.
- memoize되는 function은 size-effect가 없어야 한다.
- memoize되는 function은 parameter이외의 다른 정보에 의존하면 안된다.