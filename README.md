# CineMovie-Database

Hey, hello! This is my Code Challenge implementation for iOS Dev job at ArcTouch!

Sorry for my bad UI design! HAHA I've got to say that as an UX designer, I'm a very good developer! HAHA

I'm using Swift Coordinators and View Presenter design patterns, so, the main app presentation controller is "MainCoordinator.swift".

My implementation is pretty simple: you have the startCoordinator method which creates first view controller and tableView to display all movies. When you touch any tableview row, the view controller calls a coordinator method to open the movie view controller modal. And that's it! haha

If you have any doubt, just send me a message, and I'll be glad to answer you!

## Requirements:
- Mac OSX High Sierra 10.13.6 or above.
- XCode 10.0 or above.
- iPhone or iOS Simulator running iOS 12.
- CocoaPods

## Dependencies:
I tried not to use any cocoapod dependencies, but I just can't live without "Kingfisher" pod! It is a simple way to download and cache images. It is my favorite pod ever.
A special thanks to Ashley Mills, who created `Reachability.swift` package to easily detect internet connection on apps.

### Install:
As smooth as open a directory in your terminal, to install all dependencies you just have to write:
```sh
$ pod install
```
And that's it!

## Running
Navigate to cloned directory and open `CineMovie Database.xcworkspace` file.
