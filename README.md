# FHExtensions

<p align="left">
<a href="https://github.com/FelixHerrmann/FHExtensions/releases"><img alt="GitHub version" src="https://img.shields.io/github/v/release/FelixHerrmann/FHExtensions"></a>
<a href="https://github.com/FelixHerrmann/FHExtensions/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/FelixHerrmann/FHExtensions"></a>
<a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FFelixHerrmann%2FFHExtensions"><img alt="Twitter" src="https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FFelixHerrmann%2FFHExtensions"></a>
</p>

Some usefull Foundation and UIKit Extensions.

>Will be expanded over time.

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

Add the following to the dependencies of your `Package.swift`:

```swift
.package(url: "https://github.com/FelixHerrmann/FHExtensions", from: "x.x.x")
```

### Manual

Download the files in the [Sources](https://github.com/FelixHerrmann/FHExtensions/tree/master/Sources) folder and drag them into you project.

## Usage

### `Array`

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

### `CGRect`

#### Coordinates: `x`, `y`, `top`, `bottom`, `left`, `right`, `midX`, `midY`, `center`

Convenience properties for `CGRect` coordinates.

>These properties also contains setters which will recreate the frame entirely.

### `Date`

#### `init?(_:_:_:hour:minute:second)`

This initializer can create a `Date` object by date components. It can fail if a date could not be found which matches the components.

```swift
let date = Date(23, 2, 1999)
let dateWithTime = Date(23, 2, 1999, hour: 9, minute: 41, second: 0)
```

>The time values are optional.

### `UIColor`

#### RGB: `red`, `green`, `blue`, `alpha`

These properties are based on the `getRed(_:green:blue:alpha)` method.

### `UIDevice`

#### `modelIdentifier`

With `UIDevice.current.modelIdentifier` you are able to get the model identifier of the current device as `String`.

>This works also on Mac (Catalyst).

## License

FHExtensions is available under the MIT license. See the [LICENSE](https://github.com/FelixHerrmann/FHExtensions/blob/master/LICENSE) file for more info.
