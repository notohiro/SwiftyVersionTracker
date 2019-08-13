# SwiftyVersionTracker

[![Swift](https://img.shields.io/badge/Swift-4.1%2B-orange.svg)](https://swift.org)
[![Build Status](https://www.bitrise.io/app/0a56a372c9f524d7/status.svg?token=cy653i_YsFGGSC6_qNonrw&branch=master)](https://www.bitrise.io/app/0a56a372c9f524d7)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SwiftyVersionTracker.svg)](https://img.shields.io/cocoapods/v/SwiftyVersionTracker.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/NowCastMapView.svg?style=flat)](http://cocoapods.org/pods/NowCastMapView)
![license](https://cocoapod-badges.herokuapp.com/l/URWeatherView/badge.png)
[![Twitter](https://img.shields.io/badge/twitter-@notohiro-blue.svg?style=flat)](http://twitter.com/notohiro)

## Quick Look
With SwiftyVersionTracker, you can track which versions previously installed. Convenient methods are also available.

```Swift
let tracker = try! SwiftyVersionTracker<SwiftyVersionIntInt>()

if tracker.isFirstLaunchEver {
  // do something
  // e.g. shows welcome screen
}

if tracker.isFirstLaunchForVersion {
  // do something
  // e.g. shows release note
}

if tracker.last?.major == 1 {
  // do something
  // e.g. migrate database
}
```

## Features

- [x] Track which versions of your application previously installed
- [x] Support any type of versioning literals with Swift Generics
- [x] Most of use case is covered out of the box with `SwiftyVersionIntInt`

## Usage

Japanese is [here](http://qiita.com/notohiro/items/5df626edbca03ca540d0).

### Parameters

- `isFirstLaunchEver: Bool` returns whether it's first launch or not.
- `isFirstLaunchForVersion: Bool` returns whether it's first launch for version or not.
- `isFirstLaunchForBuild: Bool` returns whether it's first launch for build or not.
- `current: T` represents current version.
- `previous: T?` represents previously installed version. This value never change until different version will be launched.
- `first: T` represents first version user installed.
- `last: T?` represents a version which last launched.
- `history: [T]` represents all the history of installed versions.

### What's `T`?

`SwiftyVersionTracker` is build on Protocol Oriented Programming. We defined `SwiftyVersion` as protocol, so you can use `SwiftyVersionTracker` with any type of versioning rules and literals.

### `SwiftyVersion`

Before using `SwiftyVersionTracker`, you must implement _class_ or _struct_ which comfirms to `SwiftyVersion`. `SwiftyVersion` is simple protocol as described below.

```Swift
public protocol SwiftyVersion: Equatable {
	associatedtype VersionLetters: Comparable
	associatedtype BuildLetters: Comparable

	var major: VersionLetters { get }
	var minor: VersionLetters { get }
	var release: VersionLetters { get }
	var build: BuildLetters { get }

	init(versionString: String?, buildString: String?) throws
}
```
If you need more explanation about software versioning, see [Wikipedia](https://en.wikipedia.org/wiki/Software_versioning). 😃

### `SwiftyVersionIntInt: SwiftyVersion`

OK, We know you wanna just using `SwiftyVersionTracker`, without any effort as possible, and most of applications using just numbers something like `version: 1.2.3, build: 10`. For you, we implemented `SwiftyVersionIntInt` which supports versioning rule using Integers only. 😉

```Swift
let version = try! SwiftyVersionIntInt(versionString: "1.2.3", buildString: "4")

XCTAssertEqual(version.major, 1)
XCTAssertEqual(version.minor, 2)
XCTAssertEqual(version.release, 3)
XCTAssertEqual(version.build, 4)
```

### `SwiftyVersionTracker`

Finally, it's time to use `SwiftyVersionTracker`!! You have two ways to initialize `SwiftyVersionTracker`.

#### 1. With Bundle

First way is with bundle, and this is _the best way_ for most applications. Initialize `SwiftyVersionTracker` _without_ parameters, initializer will try initialize `YourVersion: SwiftyVersion`
with bundle version strings. Bundle version strings are defined in target general settings in Xcode, just like below.

<img src="https://raw.githubusercontent.com/notohiro/SwiftyVersionTracker/master/VersionStrings.png" width="640">

And example code is below.

```Swift
let tracker = try! SwiftyVersionTracker<YourVersion>()
```
Looks pretty cool, huh? 😆

#### 2. With Your Own

If you have version strings in database, code or something like that, initialize `SwiftyVersionTracker` with parameters `versionString` and `buildString`.

Example below.

```Swift
let tracker = try! SwiftyVersionTracker<YourVersion>(versionString: "1.2.3", buildString: "a123")
```

#### Within App Extensions

If you wanna track versions even within App Extension, you can specify `userDefaults` parameter for sharing tracking data between application and extension.

## Requirements

- iOS 8.0+
- Xcode 11.0+

## Installation

SwiftyVersionTracker is available through [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).

### CocoaPods

To install, simply add the following line to your `Podfile`:

```ruby
platform :ios, '11.0'
use_frameworks!

pod 'SwiftyVersionTracker'
```

### Carthage

To integrate NowCastMapView into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "notohiro/SwiftyVersionTracker"
```

Run `carthage update` to build the framework and drag the built `SwiftyVersionTracker.framework` into your Xcode project.

## Have Fun?🎉

Don't forget ⭐️, and if you like this, thanks donation for coffee. ☕️

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=notohiro%40gmail%2ecom&lc=CZ&item_name=Hiroshi%20Noto&no_note=0&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHostedGuest)

## License

SwiftyVersionTracker is available under the MIT license. See the LICENSE file for more info.
