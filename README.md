# Asset Parser

#### A Simple file parser that makes your XCAssets compiler safe.

Asset parse will scan a given iOS project directory and identify the Assets.xcassets directory. It will then create a class named `R.swift` in the root directory. Simply include this class in the project and access assets as follows:

```
R.Assets.fooImage
```

### Example Usage
```
UIImage(named: R.Assets.bar)
```

Set the project to run `parser` before building and you will have a compiler safe way to access assets.