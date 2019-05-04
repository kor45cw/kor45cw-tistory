# Optimizing Images

[링크](https://www.swiftjectivec.com/optimizing-images)

- UIKit에서 무슨 일이 일어나고 있는지, 그리고 왜 그것이 이미지를 다루는지에 대해 조금 알게 되면, 사람들은 엄청난 돈을 절약할 수 있고, jetsam의 끊임없는 분노를 피할 수 있다.


## In Theory

- 266킬로바이트의 아름다운 딸의 사진은 iOS 앱에서 얼마나 많은 메모리가 필요할까?
	- 약 14메가바이트 입니다.
- 왜요?
- iOS는 본질적으로 이미지의 크기에서 그것의 메모리를 얻는다 
	- 반면에 실제 파일 크기는 그것과 훨씬 더 관련이 없다. 
	- 이 사진의 크기는 가로 1718픽셀, 세로 2048픽셀 입니다. 각 픽셀에 4바이트가 든다고 가정하면:

```
1718*2048*4/10000 = 14.07 메가바이트
```


## Rendering Pipeline

- 이미지를 로드하면 다음과 같은 세 단계로 처리된다.

1. Load
	- iOS는 압축된 이미지를 가져와 (우리 예에서) 266킬로바이트를 메모리에 로드한다. 아직 아무 걱정도 없다.
2. Decode 
	- 이제 iOS는 이미지를 취하여 GPU가 읽고 이해할 수 있는 방식으로 변환한다. 
	- 이제 압축이 풀렸고, 여기에 위에 열거된 14MB의 크기가 있습니다. 
3. Render 
	- 들리는 것처럼 이미지 데이터는 어떤 식으로든 렌더링할 준비가 되어 있다. 가로세로 60pt 이미지 뷰로만 해도

- The decoding phase가 큰 것이다. 
- 여기서 iOS는 버퍼, 특히 이미지 버퍼를 만들어냈는데, 이 버퍼는 이미지를 메모리 내 표현으로 표현하고 있다. 
- 그러므로 이 크기가 파일 크기가 아니라 이미지 자체의 비율과 본질적으로 연관되어 있다는 것은 이유가 된다. 
- 이것은 이미지를 작업할 때 메모리 소비량에 있어서 치수가 왜 그렇게 중요한지에 대한 명확한 그림을 그린다.

- 특히 UIImage의 경우, 네트워크 히트나 다른 소스로부터 받은 이미지 데이터를 줄 때, 데이터가 암호화되어 있다고 말하는 압축으로 데이터 버퍼를 디코딩한다(PNG 또는 JPEG).
- 렌더링 작업은 원샷 작업이 아니기 때문에 UIImage는 이미지 버퍼를 주변에 두어서 한 번만 디코딩할 수 있다.

- 이 아이디어를 확장하는 것 
	- iOS 앱의 하나의 통합 버퍼는 프레임 버퍼이다. 
	- 이것은 당신의 iOS 앱이 그것의 콘텐츠의 렌더된 출력을 가지고 있기 때문에 화면에 나타나는 것처럼 실제로 보여주는 것에 대한 책임이 있다. 
	- iOS 기기의 디스플레이 하드웨어는 이 픽셀당 정보를 사용하여 물리적 화면의 픽셀을 문자 그대로 조명한다.

- 여기서 타이밍이 중요하다. 초당 60프레임의 부드러운 스크롤을 얻기 위해, 프레임 버퍼는 UIKit로 앱의 창을 렌더링해야 하며, 그 정보가 변경될 때(즉, 이미지뷰에 이미지 할당) 그것에 대한 후속 하위 뷰를 제공해야 한다. 그렇게 느리면 프레임을 떨어뜨린다.

> 1/60초는 시간이 짧다고 생각하십니까? 프로 모션 장치는 1/20초까지 상승한다.


## Size Does Matter

- 우리는 이 과정과 메모리가 소비되는 것을 꽤 쉽게 상상할 수 있다. 
- 내 딸 사진을 이용해서, 나는 그 안에 정확한 이미지가 있는 이미지 뷰를 보여주는 사소한 앱을 만들었다.

```swift
let filePath = Bundle.main.path(forResource:"baylor", ofType: "jpg")!
let url = NSURL(fileURLWithPath: filePath)
let fileImage = UIImage(contentsOfFile: filePath)

// Image view
let imageView = UIImageView(image: fileImage)
imageView.translatesAutoresizingMaskIntoConstraints = false
imageView.contentMode = .scaleAspectFit
imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true

view.addSubview(imageView)
imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
```


- LLDB로 빠르게 이동하면 훨씬 더 작은 이미지 뷰를 사용하여 표시하더라도 우리가 작업 중인 이미지 치수를 알 수 있다.

```lldb
<UIIImage: 0x600003d41a40>, {1718, 2048}
```

- 만약 내가 3배 또는 2배의 장치에 있다면, 당신은 잠재적으로 그 숫자를 더 많이 곱할 수 있을 것이다. 
- vmmap을 빠르게 이동하여 이 한 이미지에서 약 14메가바이트가 사용되고 있는지 확인해 봅시다.

```
vmmap --summary baylor.memgraph
```

몇 가지가 눈에 띈다.

```
Physical footprint:         69.5M
Physical footprint (peak):  69.7M
```

우리는 거의 70메가바이트에 달하고 있는데, 이것은 우리에게 어떤 리터랙터가 반대하는지 확인할 수 있는 좋은 기준선을 제공한다. 만약 우리가 Image IO로 줄이면, 우리는 우리의 이미지 비용의 일부를 볼 수 있을 것이다.

```
vmmap --summary baylor.memgraph | grep "Image IO"

Image IO  13.4M   13.4M   13.4M    0K  0K  0K   0K  2 
```

- 그래서 이 시점에서 300 x 400 이미지 뷰에서 이미지의 전체 비용을 지불하고 있는 겁니다. 
- 이미지의 크기가 열쇠가 될 수 있지만 중요한 것도 아니다.


## Color Space

- 여러분이 요구할 메모리의 일부는 또 다른 중요한 요소인 색 공간에 의해 결정된다. 
- 픽셀당 4바이트는 빨간색, 파란색, 녹색 그리고 알파 구성요소에 대해 1바이트를 줌으로써 계산된다.

- 이것은 당신이 UIGraphicsBeginImageContextWithOptions 대신에 UIGraphicsImageRender를 사용해야 하는 한 가지 이유다. 후자는 항상 sRGB를 사용한다. 
- 이것은 당신이 원한다면 넓은 포맷을 놓치거나 당신이 더 작은 포맷으로 갈 경우 절약을 놓칠 수 있다는 것을 의미한다. iOS 12를 기준으로, UIGraphicsImageRender는 당신에게 맞는 것을 고르려고 한다.

```swift
let circleSize = CGSize(width: 60, height: 60)

UIGraphicsBeginImageContextWithOptions(circleSize, true, 0)

// Draw a circle
let ctx = UIGraphicsGetCurrentContext()!
UIColor.red.setFill()
ctx.setFillColor(UIColor.red.cgColor)
ctx.addEllipse(in: CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height))
ctx.drawPath(using: .fill)

let circleImage = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
```

- 위의 원 이미지는 픽셀당 4바이트 형식을 사용하고 있다. 만약 당신이 UIGraphicsImageRender와 함께 롤업한다면 당신은 렌더러가 자동으로 올바른 포맷을 선택하도록 함으로써 픽셀당 1바이트를 얻음으로써 최대 75%의 절감을 위해 물건을 열 수 있다.

```swift
let circleSize = CGSize(width: 60, height: 60)
let renderer = UIGraphicsImageRenderer(bounds: CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height))

let circleImage = renderer.image{ ctx in
    UIColor.red.setFill()
    ctx.cgContext.setFillColor(UIColor.red.cgColor)
    ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height))
    ctx.cgContext.drawPath(using: .fill)
}
```

## Downscaling vs Downsampling

- UIImage는 우리가 rendering pipeline을 볼 때 논의했던 대로 원본 이미지를 메모리로 압축하기 때문에 주로 이슈가 된다.
	- 이상적으로는 버퍼의 크기를 줄일 수 있는 방법이 필요하다.

대신 더 낮은 수준의 API로 downsample 해보자.

```swift
let imageSource = CGImageSourceCreateWithURL(url, nil)!
let options: [NSString:Any] = [kCGImageSourceThumbnailMaxPixelSize:400,
                               kCGImageSourceCreateThumbnailFromImageAlways:true]

if let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary) {
    let imageView = UIImageView(image: UIImage(cgImage: scaledImage))
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    
    view.addSubview(imageView)
    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
}
```

- 우리는 전과 똑같은 결과를 얻었다. 
- 하지만 여기서 우리는 바닐라 이미지를 이미지 뷰에 넣는 대신에 CGImageSourceCreateThumbnailAtIndex()를 사용하고 있다. 
- 우리의 최적화가 성과를 거두었는지를 보기 위해 다시 한 번 vmmap 실행

```
vmmap -summary baylorOptimized.memgraph

Physical footprint:         56.3M
Physical footprint (peak):  56.7M
```

- 이전에 69.5M -> 현재 56.3M (13.2M 감소)
- 엄청난 비용 절감이다.

- WWDC 18의 세션 219에서, 애플 엔지니어 카일 슬러더는 kCGImageSourceShouldCacheImp 플래그를 사용하여 디코딩이 발생할 때 바로 제어할 수 있는 흥미로운 방법을 보여주었다.

```swift
func downsampleImage(at URL:NSURL, maxSize:Float) -> UIImage
{
    let sourceOptions = [kCGImageSourceShouldCache:false] as CFDictionary
    let source = CGImageSourceCreateWithURL(URL as CFURL, sourceOptions)!
    let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways:true,
                             kCGImageSourceThumbnailMaxPixelSize:maxSize
                             kCGImageSourceShouldCacheImmediately:true,
                             kCGImageSourceCreateThumbnailWithTransform:true,
                             ] as CFDictionary
    
    let downsampledImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions)!
    
    return UIImage(cgImage: downsampledImage)
}
```

- 여기 Core Graphic은 당신이 특별히 미리 보기를 요구할 때까지 이미지 디코딩을 하지 않을 것이다. 
- 또한 두 가지 예에서 했던 것처럼 kCGImageSourceCreateThumbnailMaxPixelSize를 통과하도록 유의하십시오. 
	- 그렇지 않으면 이미지와 동일한 크기의 썸네일을 다시 가져올 수 있기 때문입니다. 

>“…최대 픽셀 크기를 지정하지 않으면, 썸네일은 전체 이미지의 크기가 될 것이고, 이것은 아마도 당신이 원하는 것이 아닐 것이다."

- 우리는 축소된 방정식의 일부를 섬네일에 넣음으로써 전보다 훨씬 더 작은 디코딩된 이미지 버퍼를 만들었다. 
- 렌더링 파이프라인에서 다시 생각해 보면, 우리는 대신에 UIImage가 디코딩할 수 있도록 전체 이미지 치수를 반영하는 대신 우리가 보여주고 있는 이미지 뷰의 크기만을 나타내는 이미지 버퍼를 통과시켰다.

## Bouns Point

- 나는 개인적으로 이것을 iOS 11에 소개된 prefetch API와 함께 사용하고 있다. 
- 우리가 테이블이나 콜렉션 뷰가 우리의 셀을 필요로 할 때 미리 이미지를 디코딩하고 있기 때문에 CPU 사용량의 스파이크를 본질적으로 도입하고 있다는 것을 기억하라.

iOS는 전력 수요를 지속적으로 관리할 때 효율적이며, 이 경우 간헐적일 가능성이 높으므로, 이와 같은 문제를 해결하기 위해 스스로 줄을 서는 것이 좋다. 이것은 또한 디코딩을 백그라운드로 옮기는데, 이것은 또 다른 의미 있는 승리다.

- Objective-C 코드 샘플:

```objc
// Use your own queue instead of a global async one to avoid potential thread explosion
- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    if (self.downsampledImage != nil || 
        self.listItem.mediaAssetData == nil) return;
    
    NSIndexPath *mediaIndexPath = [NSIndexPath indexPathForRow:0
                                                     inSection:SECTION_MEDIA];
    if ([indexPaths containsObject:mediaIndexPath])
    {
        CGFloat scale = tableView.traitCollection.displayScale;
        CGFloat maxPixelSize = (tableView.width - SSSpacingJumboMargin) * scale;
        
        dispatch_async(self.downsampleQueue, ^{
            // Downsample
            self.downsampledImage = [UIImage downsampledImageFromData:self.listItem.mediaAssetData
                               scale:scale
                        maxPixelSize:maxPixelSize];
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                self.listItem.downsampledMediaImage = self.downsampledImage;
            });
        });
    }
}
```

> 이미 완충 크기(및 그 이상)를 관리하고 있으므로 원시 이미지 자산 중 가장 큰 몫을 위해 자산 카탈로그를 사용하는 데 유의하십시오.
