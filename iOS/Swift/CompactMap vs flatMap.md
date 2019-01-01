# `CompactMap` vs `flatMap`

## When to use `compactMap`
-  compactMap은 nil 값을 필터링 해줌

### 왜 `compactMap`이라는 이름인가
- filterMap이라고 할 경우 오해할 가능성이 있어서

## When to use `flatMap`
- `flatten` & `map`
- 여러 배열을 한개의 배열로 평평하게 만들때 사용
- ex> [1,2,3], [4,5,6] -> [[1,2,3], [4,5,6]] -> [1,2,3,4,5,6]

## Conclusion
- 옵셔널 벨류를 없애고 싶으면 compactMap을 그게 아니면 flatMap이나 map을 사용하면 된다