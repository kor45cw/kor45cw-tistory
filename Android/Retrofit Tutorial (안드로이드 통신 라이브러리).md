# Retrofit2 Tutorial (안드로이드 통신 라이브러리)

Android Retrofit을 소개합니다.

Retrofit은 HTTP API를 자바 인터페이스 형태로 사용할 수 있게 만든 라이브러리 입니다.


## Retrofit 소개
기본적으로 REST API 통신을 위해 구현된 라이브러리입니다. AsyncTask 없이 background Thread에서 실행되며 callBack을 통해 main thread에서의 UI 업데이트를 간단하게 할수 있도록 제공합니다.

* [Retrofit 홈페이지](http://devflow.github.io/retrofit-kr/)

## 프로젝트에서 사용하는 것 
* Retrofit : 통신 라이브러리
* Butterknife : 안드로이드 bind 라이브러리
* JSONPlaceholder : JSON 형식의 REST API를 연습해볼 수 있는 홈페이지

## Retrofit 설정 (Android Studio 2.2.3 기준)
* 현재 프로젝트는 Json 형태의 response와 request를 가정하고 있습니다.
* 아래의 2.1.0은 현재 최신 버전입니다. 더 업그레이드 된 버전이 있다면 홈페이지에서 확인 후 사용하시기 바랍니다.
* [참고링크](https://github.com/kor45cw/Retrofit-tutorial/blob/master/app/build.gradle)

Retrofit 라이브러리 사용을 위해 gradle에 다음의 설정을 해주도록 합니다.

```groovy
dependencies {
	compile 'com.squareup:otto:1.3.8'
	compile 'com.squareup.retrofit2:retrofit:2.1.0'
	compile 'com.squareup.retrofit2:converter-gson:2.1.0'
}
```

이후 AndroidMenifest.xml에서 Internet 사용 허가를 추가합니다

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```


## API service 생성하기
* 통신을 하는 주소, 방법 등을 세팅하는 파일입니다.
* [참고링크](https://github.com/kor45cw/Retrofit-tutorial/blob/master/app/src/main/java/com/kor45cw/retrofitexample/Retrofit/RetroBaseApiService.java)

```java
public interface RetroBaseApiService {

    final String Base_URL = "http://jsonplaceholder.typicode.com";

    @GET("/posts/{userId}")
    Call<ResponseGet> getFirst(@Path("userId") String id);

    @GET("/posts")
    Call<List<ResponseGet>> getSecond(@Query("userId") String id);

    @FormUrlEncoded
    @POST("/posts")
    Call<ResponseGet> postFirst(@FieldMap HashMap<String, Object> parameters);

    @PUT("/posts/1")
    Call<ResponseGet> putFirst(@Body RequestPut parameters);

    @FormUrlEncoded
    @PATCH("/posts/1")
    Call<ResponseGet> patchFirst(@Field("title") String title);

    @DELETE("/posts/1")
    Call<ResponseBody> deleteFirst();
}
```

Service는 interface로 생성해야 합니다.<br>
그 안의 구성은 위와 같습니다<br>

1. getFirst
	1. @GET("/posts/{userId}") : GET 방식의 통신이며, http://jsonplaceholder.typicode.com/posts/{userId}의 주소를 호출합니다.
	2. Call\<ResponseGet> : ResponseGet형식으로 된 JSON을 통신을 통해 받습니다.
	3. @Path("userId") String id : id로 들어간 String 값을 1.에서 말한 {userId}로 넘겨줍니다. 즉 id에 "1"이라는 값이 들어가면 통신의 최종적인 주소는 http://jsonplaceholder.typicode.com/posts/1 이 되는 것입니다.

2. getSecond
    1. @GET("/posts") : 역시 GET 방식의 통신이며, http://jsonplaceholder.typicode.com/posts의 주소를 호출합니다.
    2. Call\<List\<ResponseGet>> : 이번에는 ResponseGet형식으로 된 JSON 여러개를 통신을 통해 받습니다.
    3. @Query("userId") String id : getFirst와 달리 뒤에 붙는 파라미터가 없습니다. 이번 통신방식은 id에 "1"값이 들어가게 된다면 http://jsonplaceholder.typicode.com/posts?userId=1 을 호출하는 것과 같은 형태를 띄게 됩니다. 여기서 @Query Annotation은 GET방식에서만 사용가능합니다.

3. postFirst
    1. @POST("/posts") : POST 방식의 통신이며, 주소는 위와 같은 방식입니다.
    2. @FieldMap HashMap\<String, Object> parameters : Field 형식을 통해 넘겨주는 값들이 여러개일 때 FieldMap을 사용합니다. Retrofit에서는 Map보다는 HashMap형식을 쓰기를 권장하고 있습니다.
    3. @FormUrlEncoded : Field 형식을 사용할 때는 Form이 Encoding되어야 합니다. 따라서 FormUrlEncoded라는 Annotation을 해주어야 합니다.
    4. @Field 형식의 경우에는 주로 POST 방식의 통신을 할때 사용합니다. GET 방식에서는 사용이 불가능합니다.

4. putFirst
    1. @PUT("/posts/1") : PUT 방식의 통신이며, 주소는 위와 같은 방식입니다.
    2. @Body RequestPut parameters : 통신을 통해 전송하는 값이 특정 JSON 형식일 때 그러한 형태를 매번 만들지 않고 객체를 통해서 넘겨주는 방식입니다. 이러한 방식에서는 @Body라는 Annotation을 사용합니다. (PUT뿐만 아니라 다른 통신 방식에서도 마찬가지로 사용가능합니다)

5. patchFirst
    1. @PATCH("/posts/1") : PATCH 방식의 통신이며, 주소는 위와 같은 방식입니다.
    2. @Field("title") String title : patch방식을 통해 title에 해당하는 값을 넘기기 위해 사용합니다. 
    3. @FormUrlEncoded : 위에서의 설명과 같이 Field 형식을 사용하기에 추가해주어야합니다.

6. deleteFirst
    1. @DELETE("/posts/1") : DELETE 방식의 통신이며, 주소는 위와 같은 방식입니다.
    2. Call\<ResponseBody> : ResponseBody는 통신을 통해 되돌려 받는 값이 없을 경우 사용합니다.

* DELETE방식에서 @Body를 사용하기 위해선 다음처럼 해야합니다

```java
@HTTP(method = "DELETE", path = "/Arahant/Modification/Profile/Image/User", hasBody = true)
Call<ResponseBody> delete(@Body RequestGet parameters);
```

## Custom ResponseBody & RequestBody
* 매번 통신을 통해 받은 값을 get("item")과 같은 식으로 분류하는 것은 번거롭습니다.
* 매번 HashMap을 통해서 파라미터를 생성하는 것은 비효율적입니다.

* 그래서 GSON 라이브러리를 통해 JSON을 객체로 변환하고, 객체를 JSON으로 변환합니다.
* compile 'com.squareup.retrofit2:converter-gson:2.1.0' 을 Gradle에 추가한 이유입니다.

* 우선 객체를 만들어보도록 하겠습니다.
* [참고링크 - RequestBody](https://github.com/kor45cw/Retrofit-tutorial/tree/master/app/src/main/java/com/kor45cw/retrofitexample/Retrofit/RequestBody)

```java
public class RequestPut {

    public final int userId;
    public final int id;
    public final String title;
    public final String body;

    public RequestPut(HashMap<String, Object> parameters) {
        this.userId = (int) parameters.get("userId");
        this.id = (int) parameters.get("id");
        this.title = (String) parameters.get("title");
        this.body = (String) parameters.get("body");
    }
}
```
위 처럼 생성하게 되면 다음과 같은 JSON 형식으로 변환됩니다.

```json
[
userId : 100,
id : 101,
title : this is title,
body : this is body
]
```


* [참고링크 - ResponseBody](https://github.com/kor45cw/Retrofit-tutorial/tree/master/app/src/main/java/com/kor45cw/retrofitexample/Retrofit/ResponseBody)

```java
public class ResponseGet {

    public final int userId;
    public final int id;
    public final String title;
    public final String body;

    public ResponseGet(int userId, int id, String title, String body) {
        this.userId = userId;
        this.id = id;
        this.title = title;
        this.body = body;
    }

}
```
위 처럼 생성하게 되면 다음과 같은 JSON 형식이 자동으로 ResponseGet으로 변환됩니다

```json
[
userId : 100,
id : 101,
title : this is title,
body : this is body
]
```

## Retrofit Client
* 통신을 위한 준비는 위에서 모두 마쳤습니다. 이제 실제로 통신을 할 시간입니다.
* 통신을 하기 위해서는 Retrofit Instance를 생성해야합니다.
* [참고링크](https://github.com/kor45cw/Retrofit-tutorial/blob/master/app/src/main/java/com/kor45cw/retrofitexample/Retrofit/RetroClient.java)

```java
	private static class SingletonHolder {
        private static RetroClient INSTANCE = new RetroClient(mContext);
    }

    public static RetroClient getInstance(Context context) {
        if (context != null) {
            mContext = context;
        }
        return SingletonHolder.INSTANCE;
    }

    private RetroClient(Context context) {
        retrofit = new Retrofit.Builder()
                .addConverterFactory(GsonConverterFactory.create())
                .baseUrl(baseUrl)
                .build();
    }

    public RetroClient createBaseApi() {
        apiService = create(RetroBaseApiService.class);
        return this;
    }
```
BaseUrl을 통해 Retrofit 인스턴스를 생성하고 있습니다. 인스턴트 생성할 때 addConverterFactory(GsonConverterFactory.create())를 추가하면서 객체와 JSON의 변환을 자동으로 하도록 설정하였습니다.


```java
	public void getSecond(String id, final RetroCallback callback) {
        apiService.getSecond(id).enqueue(new Callback<List<ResponseGet>>() {
            @Override
            public void onResponse(Call<List<ResponseGet>> call, Response<List<ResponseGet>> response) {
                if (response.isSuccessful()) {
                    callback.onSuccess(response.code(), response.body());
                } else {
                    callback.onFailure(response.code());
                }
            }

            @Override
            public void onFailure(Call<List<ResponseGet>> call, Throwable t) {
                callback.onError(t);
            }
        });
    }
```

* GET 방식으로 통신하는 방식입니다. id를 넘기고 enqueue를 통해서 결과값을 Callback으로 넘겨받습니다.
* onResponse는 통신을 하였을 경우에 값을 돌려받는 곳입니다.
* onFailure은 통신을 하지 못하였을 경우에 에러를 출력하는 공간입니다.
* response.isSuccessful() 함수의 경우 결과 코드가 200범위 일때 참값을 반환합니다. 즉, 정상적으로 통신이 이루어졌다는 응답을 받은 경우 참값을 반환합니다.


```java
    public void postFirst(HashMap<String, Object> parameters, final RetroCallback callback) {
        apiService.postFirst(parameters).enqueue(new Callback<ResponseGet>() {
            @Override
            public void onResponse(Call<ResponseGet> call, Response<ResponseGet> response) {
                if (response.isSuccessful()) {
                    callback.onSuccess(response.code(), response.body());
                } else {
                    callback.onFailure(response.code());
                }
            }

            @Override
            public void onFailure(Call<ResponseGet> call, Throwable t) {
                callback.onError(t);
            }
        });
    }
```

* POST 방식으로 통신하는 방식입니다. parameters 를 함수 호출전에 만들어서 input으로 넘기고, 위에서 설명한 방식으로 값을 가져옵니다.


``` java
    public void putFirst(HashMap<String, Object> parameters, final RetroCallback callback) {
        apiService.putFirst(new RequestPut(parameters)).enqueue(new Callback<ResponseGet>() {
            @Override
            public void onResponse(Call<ResponseGet> call, Response<ResponseGet> response) {
                if (response.isSuccessful()) {
                    callback.onSuccess(response.code(), response.body());
                } else {
                    callback.onFailure(response.code());
                }
            }

            @Override
            public void onFailure(Call<ResponseGet> call, Throwable t) {
                callback.onError(t);
            }
        });
    }
```

* PUT 방식으로 통신하는 방식입니다. parameters 를 함수 호출전에 만들어서 RequestPut객체를 만들도록 하였습니다. 값을 전달받는 방식은 위에 설명한 방식과 같습니다.

## Retrofit CallBack
* retrofit의 통신은 background Thread에서 돌아갑니다. 이렇게 실행된 결과값을 UI Thread에서 사용하기 위해서는 CallBack 함수가 필요합니다.
* [참고링크](https://github.com/kor45cw/Retrofit-tutorial/blob/master/app/src/main/java/com/kor45cw/retrofitexample/Retrofit/RetroCallback.java)

```java
public interface RetroCallback<T> {
    void onError(Throwable t);

    void onSuccess(int code, T receivedData);

    void onFailure(int code);
}
```
error, success, fail로 상황을 나눠 callback을 받을 수 있도록 설정하였습니다.<br>
receivedData는 통신마다 다른 output을 받기 때문에 Generic으로 설정하였습니다.

## 실제로 통신을 해봅시다!!
* 이제 드디어 실제로 통신을 할 모든 준비가 끝났습니다.
* UI를 생성하고 연결한 후에 통신을 테스트해봅시다.
* [참고링크](https://github.com/kor45cw/Retrofit-tutorial/blob/master/app/src/main/java/com/kor45cw/retrofitexample/MainActivity.java)

```java
	@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ButterKnife.bind(this);

        retroClient = RetroClient.getInstance(this).createBaseApi();
        mLink.setMovementMethod(LinkMovementMethod.getInstance());
    }
```
onCreate에서 Retrofit 인스턴스를 생성합니다.


```java
	@OnClick(R.id.get1)
    void get1() {
        Toast.makeText(this, "GET 1 Clicked", Toast.LENGTH_SHORT).show();
        retroClient.getFirst("1", new RetroCallback() {
            @Override
            public void onError(Throwable t) {
                Log.e(LOG, t.toString());
                codeResultTextView.setText("Error");
                idResultTextView.setText("Error");
                titleResultTextView.setText("Error");
                useridResultTextView.setText("Error");
                bodyResultTextView.setText("Error");
            }

            @Override
            public void onSuccess(int code, Object receivedData) {
                ResponseGet data = (ResponseGet) receivedData;
                codeResultTextView.setText(String.valueOf(code));
                idResultTextView.setText(String.valueOf(data.id));
                titleResultTextView.setText(data.title);
                useridResultTextView.setText(String.valueOf(data.userId));
                bodyResultTextView.setText(data.body);
            }

            @Override
            public void onFailure(int code) {
                codeResultTextView.setText(code);
                idResultTextView.setText("Failure");
                titleResultTextView.setText("Failure");
                useridResultTextView.setText("Failure");
                bodyResultTextView.setText("Failure");
            }
        });
    }
```
GET 1 버튼을 눌렀을 경우 어떤식으로 작동하게 해놓았는지 보여줍니다.<br>
통신 오류가 있을 경우에는 모든 text에서 Error를<br>
통신 성공 (code가 200범위) 했을 때는 각 text에 맞는 값을 <br>
통신 실패 (code가 200범위가 아님)일때는 code text를 제외한 나머지에는 Failure를 보여주도록 하였습니다 <br><br>

실제로 Patch 버튼을 눌렀을 경우 결과값
![final_image.png](https://raw.githubusercontent.com/kor45cw/Retrofit-tutorial/master/output.png)

## 마무리
* Retrofit의 기초적인 사용법을 알아보았습니다.
* 위의 방식 이외에도 다양한 방식으로 통신을 할 수 있으며, RxJava역시 지원을 합니다.
* 다음 시간에는 RxJava Adapter를 사용한 통신방식을 소개하도록 하겠습니다.
* 이번 포스팅에서 사용되었던 코드 예제는 [Github - kor45cw/Retrofit-tutorial](https://github.com/kor45cw/Retrofit-tutorial)에서 확인하실수 있습니다.

질문 및 지적은 댓글로 해주시면 감사하겠습니다.
