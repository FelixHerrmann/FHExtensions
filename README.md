# FHExtensions

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFelixHerrmann%2FFHExtensions%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/FelixHerrmann/FHExtensions)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFelixHerrmann%2FFHExtensions%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/FelixHerrmann/FHExtensions)
[![Version](https://img.shields.io/github/v/release/FelixHerrmann/FHExtensions)](https://github.com/FelixHerrmann/FHExtensions/releases)
[![License](https://img.shields.io/github/license/FelixHerrmann/FHExtensions)](https://github.com/FelixHerrmann/FHExtensions/blob/master/LICENSE)
[![Tweet](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FFelixHerrmann%2FFHExtensions)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FFelixHerrmann%2FFHExtensions)

Some useful Foundation and UIKit Extensions.

>Will be expanded over time.


## Requirements
- macOS 10.10+
- iOS 9.0+
- tvOS 9.0+


## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

Add the following to the dependencies of your `Package.swift`:

```swift
.package(url: "https://github.com/FelixHerrmann/FHExtensions.git", from: "x.x.x")
```

### Manual

Download the [Sources](/Sources) folder and drag it into you project.


## Usage

### [Array](/Sources/FHExtensions/Foundation/Array.swift)

#### `subscript(safe index: Index) -> Element?`

This subscript checks, if the index is in range. 

Getting array values works like that:

```swift
let array = [0, 1, 2]

print(array[1]) // 1
print(array[safe: 1]) // Optional(1)

print(array[3]) // Fatal error: Index out of range
print(array[safe: 3]) // nil
```

Setting array values works also safely:

```swift
var array = [0, 1, 2]

array[safe: 2] = 3
print(array) // [0, 1, 3]

array[safe: 3] = 4
print(array) // [0, 1, 3]
```


### [Bundle](/Sources/FHExtensions/Foundation/Bundle.swift)

#### `versionNumber`, `buildNumber`

The values for the `CFBundleShortVersionString` and `CFBundleVersion` key in the info dictionary.


### [CGRect](/Sources/FHExtensions/CoreGraphics/CGRect.swift)

#### Coordinates: `x`, `y`, `top`, `bottom`, `left`, `right`, `center`

Convenience properties for `CGRect` coordinates.

>These properties also contains setters which will recreate the frame entirely.


### [Date](/Sources/FHExtensions/Foundation/Date.swift)

#### `init?(_:_:_:hour:minute:second:timeZone)`

This initializer can create a `Date` object by date components. It can fail if a date could not be found which matches the components.

```swift
let date = Date(23, 2, 1999)
let dateWithTimeAndTimeZone = Date(23, 2, 1999, hour: 9, minute: 41, second: 0, timeZone: TimeZone(secondsFromGMT: 0))
```

>The time values and time zone are optional.


### [JSONDecoder](/Sources/FHExtensions/Foundation/JSONDecoder.swift)

#### `DateDecodingStrategy.iso8601withFractionalSeconds`

An ISO 8601 `DateDecodingStrategy` with fractional seconds.
Something like `1999-02-23T09:41:00.000Z` will work with the decoder.


### [JSONEncoder](/Sources/FHExtensions/Foundation/JSONEncoder.swift)

#### `DateEncodingStrategy.iso8601withFractionalSeconds`

An ISO 8601 `DateEncodingStrategy` with fractional seconds.
Something like `1999-02-23T09:41:00.000Z` will be the output from the encoder.


### [String](/Sources/FHExtensions/Foundation/String.swift)

#### `capitalizedFirst`

A copy of the string where the first letter is capitalized.


### [UIColor](/Sources/FHExtensions/UIKit/UIColor.swift)

#### RGB: `red`, `green`, `blue`, `alpha`

These properties are based on the `getRed(_:green:blue:alpha)` method.

#### `init?(hex:)`

This initializer can create a `UIColor` object by a hex string. It can fail if the string has not the correct format.
It allows hex strings with and without alpha, the hash symbol is not required and capitalization does not matter.

```swift
let yellow: UIColor? = UIColor(hex: "#ffff00ff")
```

#### `createHex(alpha:hashSymbol:)`

This method creates a hex string from the color instance.

```swift
let yellow = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
let hexString: String = yellow.createHex(alpha: true)
print(hexString) // "#ffff00ff"
```


### [UIDevice](/Sources/FHExtensions/UIKit/UIDevice.swift)

#### `modelIdentifier`

With `UIDevice.current.modelIdentifier` you are able to get the model identifier of the current device as `String`.

>This works also on Mac (Catalyst).


### [UIDirectionalPanGestureRecognizer](/Sources/FHExtensions/UIKit/UIDirectionalPanGestureRecognizer.swift)

A concrete subclass of **UIPanGestureRecognizer** that cancels if the specified direction does not match.

```swift
let directionalPanRecognizer = UIDirectionalPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
directionalPanRecognizer.direction = .vertical
view.addGestureRecognizer(directionalPanRecognizer)
```

> The `touchesMoved(_:with:)` is not called on trackpad and mouse events.
Use the `UIGestureRecognizerDelegate.gestureRecognizerShouldBegin(_:)` instead if the `allowedScrollTypesMask` is set to `UIScrollTypeMask.discrete` or `UIScrollTypeMask.continuous`.


## License

FHExtensions is available under the MIT license. See the [LICENSE](/LICENSE) file for more info.
