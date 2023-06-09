# VideoPlayer_Basic_Framework
 
Simple Video Player app with a framework which can be imported and used to add Video view to the UI.
The Video will auto play.

There are two functions exposed with respective documentation in their own framework files.

[Documentation Link](https://sensehack.github.io/VideoPlayer_Basic/documentation/basicavplayer/)

## Demo

![simulator](https://raw.githubusercontent.com/SensehacK/VideoPlayer_Basic/58638b1d24cc1a886358de75b0c6cf2e7a09a16d/simulator.gif)

## Quirks

iOS 16.4 simulator doesn't display video output for HLS streams. Should work fine for physical devices and previous iOS simulators.
[Thread Simulator Bug](https://developer.apple.com/forums/thread/727288)

## Config

Minimum deployment target shifted to 15.0 due to a bug on iOS 16.4
3 different type of videos for testing.

### Swift DocC command line

#### Local Build
```swift
xcodebuild docbuild \
    -scheme BasicAVPlayer \
    -destination 'name=iPhone 14 Pro' \
    -derivedDataPath ./build
```

#### Github Pages build

```swift
xcodebuild docbuild -scheme BasicAVPlayer \
-destination generic/platform=iOS \
OTHER_DOCC_FLAGS="--transform-for-static-hosting --output-path docs --hosting-base-path VideoPlayer_Basic"
```

## Export

[Releases](https://github.com/SensehacK/VideoPlayer_Basic/releases)

### XcFramework

To Generate archive for iOS framework

#### Generic iOS 
```swift
xcodebuild archive \
-scheme BasicAVPlayer \
-destination "generic/platform=iOS" \
-archivePath ../output/BasicAVPlayer-iOS \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES
```

#### Simulator
```swift
xcodebuild archive \
-scheme BasicAVPlayer \
-destination "generic/platform=iOS Simulator" \
-archivePath ../output/BasicAVPlayer-Sim \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES
```

### Xc Framework export
```swift
xcodebuild -create-xcframework \
-framework ./BasicAVPlayer-iOS.xcarchive/Products/Library/Frameworks/BasicAVPlayer.framework \
-framework ./BasicAVPlayer-Sim.xcarchive/Products/Library/Frameworks/BasicAVPlayer.framework \
-output ./BasicAVPlayer.xcframework
```

