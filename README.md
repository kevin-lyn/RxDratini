# RxDratini ![CI Status](https://travis-ci.org/kevin0571/RxDratini.svg?branch=master) [![codecov](https://codecov.io/gh/kevin0571/RxDratini/branch/master/graph/badge.svg)](https://codecov.io/gh/kevin0571/RxDratini) ![CocoaPods](http://img.shields.io/cocoapods/v/RxDratini.svg?style=flag) ![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg) ![Swift Pacakge Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg) ![License](https://img.shields.io/cocoapods/l/RxDratini.svg?style=flag)
RxDratini provides [RxSwift](https://github.com/ReactiveX/RxSwift/) extensions for [Dratini](https://github.com/kevin0571/Dratini).

## Requirements
- Xcode 8.0+
- Swift 3.0

## Usage

**CocoaPods**
```ruby
pod 'RxDratini'
```

**Carthage**
```ruby
github "kevin0571/RxDratini"
```

**Swift Package Manager**
```ruby
dependencies: [
    .Package(url: "https://github.com/kevin0571/RxDratini.git", majorVersion: 1)
]
```

### Example
Subscribe for request:
```swift
// requestQueue, request and disposeBag are already initialized
request.asObservable(in: requestQueue).subscribe(onNext: { response in
    // received response
}, onError: { error in
    // received error
}).addDisposableTo(disposeBag)
```

Subscribe for response:
```swift
// requestQueue and disposeBag are already initialized
TestGetResponse.asObservable(in: requestQueue).subscribe(onNext: { response in
    // received response
}, onError: { error in
    // received error
}).addDisposableTo(disposeBag)
```

For usage of Dratini, please visit: https://github.com/kevin0571/Dratini
