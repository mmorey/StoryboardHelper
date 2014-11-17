# StoryboardHelper

[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/mmorey/StoryboardHelper/blob/master/LICENSE.md)
[![Twitter: @xzolian](https://img.shields.io/badge/contact-@xzolian-blue.svg?style=flat)](https://twitter.com/xzolian)

StoryboardHelper is a Swift script that searches a given input path for Storyboard files and generates helpful access functions as a UIStoryboard extension.

```swift
import UIKit

public extension UIStoryboard {

    class func MainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle:nil)
    }

    class func AnotherStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Another", bundle:nil)
    }
}
```

You now have code autocompletion and can avoid using cumbersome strings throughout your project.

## Installation

1) Download the [script](https://raw.githubusercontent.com/mmorey/StoryboardHelper/master/StoryboardHelper.swift) and place it in your PATH or somewhere else easily accessible. I place it in the the `scripts` folder of my project that way other team members can use it.

```bash
$ cd scripts
$ curl -O https://raw.githubusercontent.com/mmorey/StoryboardHelper/master/StoryboardHelper.swift
```

2) Make the script executable.

```bash
$ chmod +x StoryboardHelper.swift
```

## Usage

__For automated use:__

1) Add a file to your Xcode project to hold the output of the script, for example `UIStoryboardExtensions.swift`.

2) Add a build script to the build phases.

```bash
"${SRCROOT}/scripts/StoryboardHelper.swift" "${SRCROOT}" "${SRCROOT}/source/UIStoryboardExtensions.swift"
```

__For manual use:__

1) Add a file to your Xcode project to hold the output of the script, for example `UIStoryboardExtensions.swift`.

2) Execute the script using Terminal:

```bash
$ ./StoryboardHelper.swift ExampleProjectPath ExampleProjectPath/UIStoryboardExtensions.swift
```

## Issues / TODO

* Proper argument parsing using [OptionKit](https://github.com/nomothetis/OptionKit)
* Easier installation, need something as easy as Ruby gems

## Attribution

* [SBConstants](http://paul-samuels.com/blog/2013/01/31/storyboard-constants/)
* [xcres](https://github.com/mrackwitz/xcres)
* [Alexandros Salazar](http://nomothetis.svbtle.com/swift-for-scripting)
* [Marin Usalj](https://speakerdeck.com/supermarin/swift-for-cli-tools)

## License

StoryboardHelper is available under MIT License. See the [LICENSE.md](https://github.com/mmorey/StoryboardHelper/blob/master/LICENSE.md) file for more info.
