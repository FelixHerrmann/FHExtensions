# FHExtensions

<p align="left">
<a href="https://github.com/FelixHerrmann/FHExtensions/releases"><img alt="GitHub version" src="https://img.shields.io/github/v/release/FelixHerrmann/FHExtensions"></a>
<a href="https://github.com/FelixHerrmann/FHExtensions/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/FelixHerrmann/FHExtensions"></a>
<a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FFelixHerrmann%2FFHExtensions"><img alt="Twitter" src="https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FFelixHerrmann%2FFHExtensions"></a>
</p>

Some usefull Foundation and UIKit Extensions.

>Will be expanded over time.

## Requirements
- macOS 10.10+
- iOS 8.0+
- tvOS 9.0+

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

Add the following to the dependencies of your `Package.swift`:

```swift
.package(url: "https://github.com/FelixHerrmann/FHExtensions", from: "x.x.x")
```

### Manual

Download the files in the [Sources](https://github.com/FelixHerrmann/FHExtensions/tree/master/Sources) folder and drag them into you project.

## Usage

### [`Array`](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/Array.swift)

#### `subscript(safe index: Index) -> Element?`

This subscript checks, if the index is in range. 

<br>

Getting array values works like that:

```swift
let array = [0, 1, 2]

print(array[1]) // 1
print(array[safe: 1]) // Optional(1)

print(array[3]) // Fatal error: Index out of range
print(array[safe: 3]) // nil
```

<br>

Setting array values works also safely:

```swift
var array = [0, 1, 2]

array[safe: 2] = 3
print(array) // [0, 1, 3]

array[safe: 3] = 4
print(array) // [0, 1, 3]
```

### [`CGRect`](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/CGRect.swift)

#### Coordinates: `x`, `y`, `top`, `bottom`, `left`, `right`, `midX`, `midY`, `center`

Convenience properties for `CGRect` coordinates.

>These properties also contains setters which will recreate the frame entirely.

### [`Date`](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/Date.swift)

#### `init?(_:_:_:hour:minute:second)`

This initializer can create a `Date` object by date components. It can fail if a date could not be found which matches the components.

```swift
let date = Date(23, 2, 1999)
let dateWithTime = Date(23, 2, 1999, hour: 9, minute: 41, second: 0)
```

>The time values are optional.


### [`JSONDecoder`](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/JSONDecoder.swift)

#### `DateDecodingStrategy.iso8601withFractionalSeconds`

An ISO 8601 `DateDecodingStrategy` with fractional seconds.
Something like `1999-02-23T08:41:00.000Z` will work with the decoder.

### [`JSONEncoder`](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/JSONEncoder.swift)

#### `DateEncodingStrategy.iso8601withFractionalSeconds`

An ISO 8601 `DateEncodingStrategy` with fractional seconds.
Something like `1999-02-23T08:41:00.000Z` will be the output from the encoder.

### [`UIColor`](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/UIColor.swift)

#### RGB: `red`, `green`, `blue`, `alpha`

These properties are based on the `getRed(_:green:blue:alpha)` method.

### [`UIDevice`](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/UIDevice.swift)

#### `modelIdentifier`

With `UIDevice.current.modelIdentifier` you are able to get the model identifier of the current device as `String`.

>This works also on Mac (Catalyst).

### [`UserDefault`](https://github.com/FelixHerrmann/FHExtensions/blob/master/Sources/FHExtensions/UserDefault.swift)

A property wrapper which stores the wrapped value in the `UserDefaults`.

```swift
@UserDefault("test", defaultValue: "") var test: String
```

> The wrapped value must be of type `UserDefaultType`.
For every other type use the `CodableUserDefault` wrapper.

#### OptionalUserDefault

The `UserDefault` property wrapper but for optional types.

```swift
@OptionalUserDefault("test") var test: String?
```

#### CodableUserDefault

This property wrapper works exactly like the `UserDefault` one but accepts any type that conforms to the `Codable` protocol.

```swift
struct TestType: Codable {
    let name: String
}

@CodableUserDefault("test", defaultValue: TestType(name: "") var test: TestType
```

## License

FHExtensions is available under the MIT license. See the [LICENSE](https://github.com/FelixHerrmann/FHExtensions/blob/master/LICENSE) file for more info.
