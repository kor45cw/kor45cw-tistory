# Gradient Layer

## Step 1

```swift
var gradientLayer: CAGradientLayer = {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [#Color1, #Color2]//Colors you want to add
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    gradientLayer.frame = CGRect.zero
   return gradientLayer
}()
```

## Step 2

```swift
yourView.layer.addSublayer(gradientLayer)
```

## Step 3

```swift
gradientLayer.frame = yourView.bounds
```