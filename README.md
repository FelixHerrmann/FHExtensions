# FHExtensions

<p align="left">
<a href="https://github.com/FelixHerrmann/FHExtensions/releases"><img alt="GitHub version" src="https://img.shields.io/github/v/release/FelixHerrmann/FHExtensions"></a>
<a href="https://github.com/FelixHerrmann/FHExtensions/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/FelixHerrmann/FHExtensions"></a>
<a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FFelixHerrmann%2FFHExtensions"><img alt="Twitter" src="https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FFelixHerrmann%2FFHExtensions"></a>
</p>

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

Download the files in the [Sources](https://github.com/FelixHerrmann/FHExtensions/tree/master/Sources) folder and drag them into you project.


## Usage

### [Array](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/Array.swift)

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


### [Bundle](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/Bundle.swift)

#### `versionNumber`, `buildNumber`

The values for the `CFBundleShortVersionString` and `CFBundleVersion` key in the info dictionary.


### [CGRect](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/CGRect.swift)

#### Coordinates: `x`, `y`, `top`, `bottom`, `left`, `right`, `midX`, `midY`, `center`

Convenience properties for `CGRect` coordinates.

>These properties also contains setters which will recreate the frame entirely.


### [Date](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/Date.swift)

#### `init?(_:_:_:hour:minute:second)`

This initializer can create a `Date` object by date components. It can fail if a date could not be found which matches the components.

```swift
let date = Date(23, 2, 1999)
let dateWithTime = Date(23, 2, 1999, hour: 9, minute: 41, second: 0)
```

>The time values are optional.


### [JSONDecoder](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/JSONDecoder.swift)

#### `DateDecodingStrategy.iso8601withFractionalSeconds`

An ISO 8601 `DateDecodingStrategy` with fractional seconds.
Something like `1999-02-23T08:41:00.000Z` will work with the decoder.


### [JSONEncoder](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/JSONEncoder.swift)

#### `DateEncodingStrategy.iso8601withFractionalSeconds`

An ISO 8601 `DateEncodingStrategy` with fractional seconds.
Something like `1999-02-23T08:41:00.000Z` will be the output from the encoder.


### [String](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/String.swift)

#### `capitalizedFirst`

A copy of the string where the first letter is capitalized.


### [UIColor](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/UIColor.swift)

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


### [UIDevice](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/UIDevice.swift)

#### `modelIdentifier`

With `UIDevice.current.modelIdentifier` you are able to get the model identifier of the current device as `String`.

>This works also on Mac (Catalyst).


### [UIDirectionalPanGestureRecognizer](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/UIDirectionalPanGestureRecognizer.swift)

A concrete subclass of **UIPanGestureRecognizer** that cancels if the specified direction does not match.

```swift
let directionalPanRecognizer = UIDirectionalPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
directionalPanRecognizer.direction = .vertical
view.addGestureRecognizer(directionalPanRecognizer)
```

> The `touchesMoved(_:with:)` is not called on trackpad and mouse events.
Use the `UIGestureRecognizerDelegate.gestureRecognizerShouldBegin(_:)` instead if the `allowedScrollTypesMask` is set to `UIScrollTypeMask.discrete` or `UIScrollTypeMask.continuous`.


### [UserDefault](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/UserDefault.swift)

A property wrapper which reads and writes the wrapped value in the `UserDefaults` store.

It supports all the types that are allowed by `UserDefaults`. 

```swift
@UserDefault("string") var string = ""
@UserDefault("int") var int = 0
@UserDefault("array") var array: [String] = []
@UserDefault("dictionary") var dictionary [String: Int] = [:]
```

In addition to that, `Optional`, `RawRepresentable` and `Codable` are supported too.
For non-`RawRepresentable` enums use `Codable`. 

```swift
@UserDefault("optional") var optional: String? = nil


enum Enumeration: String, UserDefaultStorable {
    case firstCase
    case secondCase
}

@UserDefault("enumeration") var enumeration: Enumeration = .firstCase


struct CustomType: Codable, UserDefaultStorable {
    let name: String
}

@UserDefault("codable") var codable = CustomType(name: "")
```

> The wrapped value must conform to `UserDefaultStorable`.


## License

FHExtensions is available under the MIT license. See the [LICENSE](https://github.com/FelixHerrmann/FHExtensions/blob/master/LICENSE) file for more info.
