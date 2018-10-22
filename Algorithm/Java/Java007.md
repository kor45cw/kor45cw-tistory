#[Java 문제풀이 007] 그대로 출력하기

[문제 링크](https://www.acmicpc.net/problem/11718)

##문제

입력 받은 대로 출력하는 프로그램을 작성하시오.


##풀이

```java 
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        while (scanner.hasNextLine()) {
            String input = scanner.nextLine();
            System.out.println(input);
        }

    }
}
```    