# CinematX

* **Xcode version:** 
  * **Written in** 10.2 (10E125)
  * **Compatible with** 9.3 or higher
* **iOS Deployment target:** 12.1 (Please **DO NOT** use the 12.2 simulators, yet - causes SIGABRT on run.)
* **Minimum iOS version:** 8.0 (See Podfile)

Because of several CocoaPods packages are being used in the solution, please open the project using **CinematX.xcworkspace**.

This app is a job interview project, written in my leisure time. It also happens to be my second touch with the Swift language & iOS mobile app development - the first one is [here](https://github.com/adamlonda/HelloSwift).

## Included features finnished due February 10th, 2019

* Popular movies from TMDb in a grid view, displaying posters and titles
* Movie detail containing:
  * Movie poster & title
  * Release date
  * Genres
  * Overview
* TMDb communication errors handled on UI

## February 23rd, 2019

* RxSwift refactorization of the popular movies view controller & its services in use, no longer using the Futures pod for async code handling

## Features not yet included

* Non-blocking UI feedback on network error
* Trailers playback
* Popular movies filtering via search bar
* Unit tests
