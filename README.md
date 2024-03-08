# DiiaMVPModule

Model-View-Presenter basic protocols

## Description

* `BaseModule`: _Defines module structure and provides a view controller._
* `BasePresenter`: _Facilitates model-view interaction and configures the associated view._
* `BaseView`: _Manages seamless module navigation and presentation in the MVP architecture. Provides UI-related functionalities: progress handling, error and message display._

## Useful Links

|Topic|Link|Description|
|--|--|--|
|Ministry of Digital Transformation of Ukraine|https://thedigital.gov.ua/|The Official homepage of the Ministry of Digital Transformation of Ukraine| 
|Diia App|https://diia.gov.ua/|The Official website for the Diia application

## Getting Started

### Installing

To install DiiaMVPModule using [Swift Package Manager](https://github.com/apple/swift-package-manager) you can follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for this repo with the current version:

1. In Xcode, select “File” → “Add Packages...”
1. Enter `https://github.com/diia-open-source/ios-mvpmodule.git`

or you can add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/diia-open-source/ios-mvpmodule.git", from: "1.0.0")
```

## Code Verification

### Swiftlint

It is used [SwiftLint](https://github.com/realm/SwiftLint) to enforce Swift style and conventions. The app should build and work without it, but if you plan to write code, you are encouraged to install SwiftLint.

You can run SwiftLint manully by running 
```bash
swiftlint Sources --quiet --reporter html > Scripts/swiftlint_report.html.
```
You can also set up a Git [pre-commit hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) to run SwiftLint automatically by copy Scripts/githooks into .git/hooks

## How to contribute

The Diia project welcomes contributions into this solution; please refer to the [CONTRIBUTING.md](./CONTRIBUTING.md) file for details

## Licensing

Copyright (C) Diia and all other contributors.

Licensed under the  **EUPL**  (the "License"); you may not use this file except in compliance with the License. Re-use is permitted, although not encouraged, under the EUPL, with the exception of source files that contain a different license.

You may obtain a copy of the License at  [https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12](https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12).

Questions regarding the Diia project, the License and any re-use should be directed to [modt.opensource@thedigital.gov.ua](mailto:modt.opensource@thedigital.gov.ua).
