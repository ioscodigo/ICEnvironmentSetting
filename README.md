# ICEnvironmentSetting
[![Version](https://img.shields.io/cocoapods/v/ICEnvironmentSetting.svg?style=flat)](http://cocoapods.org/pods/ICEnvironmentSetting)
[![License](https://img.shields.io/cocoapods/l/ICEnvironmentSetting.svg?style=flat)](http://cocoapods.org/pods/ICEnvironmentSetting)
[![Platform](https://img.shields.io/cocoapods/p/ICEnvironmentSetting.svg?style=flat)](http://cocoapods.org/pods/ICEnvironmentSetting)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Minimum Requirements

iOS8+
Swift 3.0
XCode 8.0


## Installation

ICEnvironmentSetting is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ICEnvironmentSetting"
```

## Usage

### Setup Environment on AppDelegate
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [	UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Default development
 	ICEnvironmentSetting.setup(window: self.window!) 
	// you can set default environment
	ICEnvironmentSetting.setup(window: self.window!,defaultEnv: .STAGGING)
	//Setup your URL API environment
	ICEnvironmentSetting.setupBaseURL(development: "DEV", staging: "STG", production: "PROD")
    return true
}

```
### Setup Listener
Add delegate on home your app

```swift
ICEnvironmentSettingDelegate
func reloadEnvironment(environment: ENVIRONMENT) {
    //Reload data when environment change
}
```

Add touch to switch environment with three fingers

```swift
ICEnvironmentSetting.setupTouch(self.view)
```

You can use string extension with modify environment 

```swift
let homeURL = "/home"
request(homeURL.ENV) //see example more info
```


## Author

Fajar Agung W, fajar@codigo.id

## License

ICEnvironmentSetting is available under the MIT license. See the LICENSE file for more info.
