#[Java 문제풀이 010] A/B

[문제 링크](https://www.acmicpc.net/problem/1008)

##문제

두 정수 A와 B를 입력받은 다음, A/B를 출력하는 프로그램을 작성하시오.


##풀이

```java 
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        double a = scanner.nextDouble();
        double b = scanner.nextDouble();
        System.out.println(a/b+"");
    }
}
```    