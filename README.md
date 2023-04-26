# VideoPlayer_Basic_Framework
 
Simple Video Player app with a framework which can be imported and used to add Video view to the UI.
The Video will auto play.

There are two functions exposed with respective documentation in their own framework files.

## Demo

![simulator](https://raw.githubusercontent.com/SensehacK/VideoPlayer_Basic/58638b1d24cc1a886358de75b0c6cf2e7a09a16d/simulator.gif)

## Config

Minimum deployment target shifted to 15.0 due to a bug on iOS 16.4
3 different type of videos for testing.

## Swift DocC command line

```swift
xcodebuild docbuild \
    -scheme BasicAVPlayer \
    -destination 'name=iPhone 14 Pro' \
    -derivedDataPath ./build
```

## Quirks

iOS 16.4 simulator doesn't display video output for HLS streams. Should work fine for physical devices and previous iOS simulators.
[Thread Simulator Bug](https://developer.apple.com/forums/thread/727288)
