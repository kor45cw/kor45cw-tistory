#[Java 문제풀이 016] 기찍 N

[문제 링크](https://www.acmicpc.net/problem/2742)

##문제

- 자연수 N이 주어졌을 때, N부터 1까지 한 줄에 하나씩 출력하는 프로그램을 작성하시오.

##풀이

```java 
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int N = scanner.nextInt();


        for (int i=N; i > 1; i--) {
            System.out.println(i);
        }

        System.out.print(1);
    }
}
```
