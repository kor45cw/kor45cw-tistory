#[Java 문제풀이 017] 구구단

[문제 링크](https://www.acmicpc.net/problem/2739)

##문제

- N을 입력받은 뒤, 구구단 N단을 출력하는 프로그램을 작성하시오. 출력 형식에 맞춰서 출력하면 된다.

##풀이

```swift 
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int N = scanner.nextInt();


        for (int i=1; i < 10; i++) {
            System.out.println(N+" * "+i+" = "+N*i);
        }
    }
}
```
