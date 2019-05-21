# 쉬운 테스트 주도 개발과 단위 테스트를 위한 5단계 방법론


- 보통 테스트 주도 개발이나 단위 테스트에서 가장 어려운 것은 뭘까?
	- 테스트 코드를 작성하는 것이다!
	- 문제는 원하는 바를 머릿속에 막연하게 떠올리고, 그것을 어떤 함수의 작동을 검증하는 무언가로 변환하는 것이다… 게다가 그놈의 코드를 작성하기도 전에!

- 테스트 주도 개발은 당신의 코드에 대한 다른 방식의 사고를요구한다. 그리고 누구도 당신에게 방법을 알려주지 않는다. 


## 막연한 생각을 테스트로 전환하는 방법	
> 기억해둘 점: 필요한 것은 사고방식에 적응하는 것이다. 그렇다 — 맨 처음엔 의식적인 노력이 다소 필요하지만, 충분히 노력하면 일상적인 것이 된다. 반복문과 조건문을 쓰듯, 오래 생각할 필요가 없이 그냥 테스트 코드를 작성하게 된다.

- 시작하기 전에, 당신이 알아야 할 한가지 중요한 점이 있다. 
- <b>목표는 완벽이 아니다!</b> 
	- 테스트 주도 개발은 반복적인 과정으로, 작은 절차들의 반복적인 수행을 의미한다. 
	- 우리는 경험에 근거한 좋은 추측을 하고싶을 뿐, 정확히 옳아야하는 것은 아니다. 
	- 어떤 작은 디테일을 고민하느라 멈추지 마라, 왜냐하면 소프트웨어 분야에선 뭐든지 항상 바뀌기 때문이다. 
	- TDD의 가장 좋은 점은 변경이 쉬운 것이고 따라서 첫 시도가 100% 정확하지 않다면, 그냥 다시 해보면 된다. 
	- 그것이 이상적인 모습이다!


## 1단계: 입력과 출력 결정하기
- 당장에는 구현을 고려하지 않는다.
- 우리의 목표: 비밀번호 강도의 측정. 이를 위해서 보통은 입력값들이 필요하고… 다음으로, 그에 근거한 출력값을 얻을 것이다.

- 입력값은 쉽다: 비밀번호.
- 결과값도 쉽다: 비밀번호의 강도를 나타내는 어떤 값이 되어야 한다. 간단하게 하려면, 비밀번호가 강력하거나 아니거나 — 즉 boolean값을 출력에 사용할 수 있다.

## 2단계: 함수 시그니처 선택하기

- 매개변수
	- 우리의 함수는 어떤 동작을 해야할까? 필요한 것은 비밀번호 뿐이다. 
	- 우리는 단 하나의 값에만 의존해 모든 측정을 할 수 있다.
- 반환값
	- 결과를 곧장 반환할 수 있다. 
	- 보다 복잡한 상황이라면, 반환값은 Promise가 된다. 
	- 또는 값을 반환하는 대신, 콜백 매개변수를 취하거나 — 아무것도 반환하지 않을 수도 있다.
- 어쨌든간에, 이 시점에서 함수 호출을 어떻게 할지 결정할 수 있다:

```js
var strong = isStrongPassword(‘password string goes here’);
```


## 3단계: 기능상 아주 작은 하나의 관점으로 판단하기
- TDD에 있어서 대부분의 사람들이 곤란에 빠지는 지점이 여기다. 당신의 머릿속은 함수를 어떻게 작성할 것인가에 대한 생각들로 가득찼지만… 작성을 시작할 때까지 당신은 코드를 정확히 어떻게 설계할 지 확신할 수 없다.

- 모든 선택지에 대해 생각하는 대신에… 그냥 작은 것에만 집중해보자.
	- 목표에 아주 조금 다가가기 위해 필요한, 최대한 간단한 동작은 뭘까?
	- 비밀번호 강도에 관해 가장 단순한 규칙은 빈 문자열이다. 
	- 이건 매우 쉽다 — 비밀번호가 비어있다면 출력값은 언제나 false여야 한다.


## 4단계: 테스트 구현
- 앞선 과정들이 TDD와 무관하게 코딩하는 것과 실제로 비슷한 걸 알겠는가?
- 주된 차이점은 함수 구현 대신, 어떻게 호출되어야 하며, 어떤 결과가 발생하는 지에 집중하고 있다는 점이다. 
	- 어떤 조건 하에서 함수가 어떻게 동작하는 지 생각하고 있다.
- 함수가 어떻게 동작하는지 테스트하고 싶은 것이다. 
	- 어떤 조건 하에서 일단 시작하고나면(특정 매개변수, 시간대, 무엇이든) 테스팅이 무척 쉬워지는데, 
	- 외부에서 동작을 바라볼 수 있기 때문이다. 그저 동작을 선택하기만 하면 구현에 대해서 알 필요가 없다.

```js
describe('isPasswordStrong', function() {
  it('should give negative result for empty string', function() {
    var password = '';
    var result = isPasswordStrong(password);
    expect(result).to.be.false;
  });
});
```	
	
	
## 5단계: 코드 구현
- 설명이 필요없다. 단지 테스트를 통과할 수 있는 최소한의 코드만 추가한다.

```js
function isPasswordStrong(password) {
  if(!password) {
    return false;
  }
}
```	
	
- 계속해서 비밀번호 강도 측정 함수를 개발하고 싶다면, 그냥 반복하면 된다. 
	- 우리는 3단계로 돌아가서, 아주 작은 다음 단계를 선택할 것이다. 
	- 4단계, 테스트 로직 추가. 
	- 5단계, 구현. 
	- 반복.	
	
	
	
	
## 더 복잡한 예제
- 테스트가 적당히 까다로운 예제는 뭐가 있을까?
- 디바운스 함수는 어떤가? 특정 시간범위 안에 이미 호출된 다른 어떤 함수도 호출하지 않음을 보장하는 것이 디바운스 함수의 개념이다. 예를 들어서 당신이 스크롤 이벤트를 조작해야 한다면, 특히 오직 사용자가 스크롤을 멈출 때만 작동하길 원한다면 이것이 매우 편리하다.
	
	
### 1단계를 다시 해보자. 
- 디바운스 함수의 입력과 출력은 무엇인가?
	- 존재하면서 어떤 시점까지는 호출되지 않는 함수를 생성하는 것이 목표이기 때문에, 
	- 첫 번째 입력값은 함수가 아마 함수일 것이다. 
	- 두 번째 입력값은 디바운스를 위한 지속시간이 된다.
	- 함수의 결과에 따라, 디바운스 함수는 원래 함수의 지연된 버전을 반환해야 하고, 비로소 함수가 호출될 것이다.	
### 2단계: 함수 시그니처. 
- 우리는 두 입력값을 함수의 매개변수로 전달하고, 함수는 새 함수를 반환한다. 간단하다.

```js
var delayedFunction = debounce(targetFunction, delayInMilliseconds);
```	
	
	
	
### 3단계: 함수를 구현할 작은 부분을 선택해야한다. 
- 디바운스가 가능한 부분은 다양하다
	- 예를 들면 지연으로, 반환된 함수를 충분한 지연시간 없이 여러번 호출한다면 호출이 안되는 것…등등.
- 하지만 일단 시작할만한 가장 단순한 것을 찾아보자. 
	- 디바운스에 의해 반환된 지연 함수를 호출한다면, 해당 함수는 일정 시간만큼 기다렸다가 원래 함수를 실행할 것이다. 
	- 내 생각엔 시작에 적당한 지점같아 보인다.	
	
	
### 4단계다. 이런 경우 테스트 코드는 어떻게 생겼을까?
- 이전과 마찬가지로, 정한 것들을 테스트와 연결해보자:	

```js
describe(‘debounce’, function() {
  it(‘should call returned function after delay passes’,
  function(done) {
    var delay = 5;
    var targetFn = function() {
      done();
    };
    var delayedFn = debounce(targetFn, delay);
    delayedFn();
  });
});
```

- 우리는 정확한 구현을 알 필요가 없다
	- 단지 앞 단계에서 얻은 정보를 곧장 테스트에 연결하면 된다. 
	- 한가지 알아둘 것은 자바스크립트에서 지연은 비동기적인 것, 따라서 우리는 비동기 테스트가 필요하다. 
	- 이건 세부 구현에 해당하지만, 당신이 자바스크립트의 작동방식을 안다면 자연스럽게 따라오는 것이며 결코 이런 특정 함수만 해당되는 것이 아니다.


### 5단계에 바로 진입해서 코드를 구현하자

```js
function debounce(targetFn, delay) {
  return function() {
    targetFn();
  };
}
```	
	
- 잠깐! 함수를 전혀 지연시키지 않잖아!
- 맞다 
	- 우리는 TDD를 실천하는 중이니까! 
	- 필요한 모든 것은 작성한 테스트를 충족하는 것이고… 이 코드는 테스트를 통과한다.
	- 누군가는 이걸 꼼수라고 하겠지만, 어쨌든 우리 모두 이것이 올바른 동작이 아닌걸 안다. 
	- TDD의 다른 말은 테스트를 통과할 정도로만 코드를 구현하는 것이므로, 그냥 넘어가자.
- 3단계로 돌아가서 구현할 또 다른 작은 동작을 선택할 것이다. 
- 한가지 매우 중요한 동작은 함수가 너무 일찍 호출되지 않는 것으로, 당장 우리 코드의 동작과 비슷하다.	

- 전진할 다음 단계가 생겼다. 4단계, 테스트 코드를 구현한다:

```js
it(‘should not run debounced function too early’, function() {
  var delay = 100;
  var targetFn = function() { };
  var delayedFn = debounce(targetFn, delay);
  delayedFn();
  // 그런데 이걸 어떻게 검증하지?
});	
```

-  Sinon.js(테스트 스텁의 한 종류라고 합니다..)를 사용하여 페이크 타이머를 생성하여 더 진행할 수 있으며, 지연 된 함수가 예상보다 일찍 호출되진 않았는지 확인할 수 있다.

```js
it(‘should not run debounced function too early’, function() {
  var clock = sinon.useFakeTimers();
  var delay = 100;
  var targetFn = sinon.spy();
  var delayedFn = debounce(targetFn, delay);
  delayedFn();
  clock.tick(delay — 1);
  clock.restore();
  sinon.assert.notCalled(targetFn);
});
```

## 결론
- 예제로 살펴본 것처럼, 우리는 모든 종류의 함수에 5단계 절차를 적용할 수 있다.
- 연습이 좀 필요하다면, 여기서 구현하기 시작한 두 함수 중 하나를 골라서, 완전히 동작할 때까지 5단계의 과정을 적용하는 연습을 해보라.
- 테스트 주도 개발은 한번 기본을 터득하고나면 어렵지 않다. 어려운 것은 사고방식을 전환하는 것이다: TDD 없이는, 무언가를 어떻게 구현할 지 직접적으로 생각한다. 하지만 TDD를 활용하면, 무엇이 어떻게 동작하길 원하는지 생각한다.


1. 어떤 입력과 출력(동작)이 함수 호출에 필요한가?
2. 코드에서 함수를 어떻게 호출할 것인지 결정하기
3. 생각하는 입력에 대한 동작의 가장 작은 부분 선택하기
4. 입력값으로 함수를 호출하는 테스트 코드를 작성하고, 동작을 검증하기
5. 테스트를 충분히 통과하는 코드를 구현

- 이런 방식의 간단한 절차를 따르면, 테스트 코드를 미리 작성하는 것이 무척 쉬워진다. 계속해서 코드를 작성하려면, 단지 3단계에서 5단계를 반복하면 된다.
- 기억하자 
	- 테스트와 코드를 구현한 후 다르게 작동해야만 하는 걸 알아채더라도, 괜찮다! 계속해서 다시하면 된다
	- 우리는 첫 술에 배부를 필요가 없으며, 그런 걸 추구해도 가로막힐 뿐이다. 
	- 이것은 TDD 만의 전유물이 아니다: 어쨌거나 당신은 코드의 일부분을 다시 작성하고 리팩토링해야 할 것이고, TDD는 변경된 코드가 망가지진 않았는지 검증하는 테스트로써 그 과정이 안전하도록 도와줄 뿐이다.