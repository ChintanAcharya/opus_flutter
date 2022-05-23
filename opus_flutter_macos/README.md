# opus_flutter_macos

The MacOS implementation of [`opus_flutter`][1].

## Usage

### Import the package

This package has been endorsed, meaning that you only need to add `opus_flutter`
as a dependency in your `pubspec.yaml`. It will be automatically included in your app
when you depend on `package:opus_flutter`.

This is what the above means to your `pubspec.yaml`:

```yaml
...
dependencies:
  ...
  opus_flutter: ^3.0.0
  ...
```

If you wish to use the MacOS package only, you can add `opus_flutter_macos` as a
dependency:

```yaml
...
dependencies:
  ...
  opus_flutter_macos: ^3.0.0
  ...
```

## How opus is contained in this package
[comment]: <> (Until Flutters Windows build system is more mature, we are follwing the recommendation from [Define distribution system for native libraries in Pub and/or Flutter]&#40;https://github.com/dart-lang/sdk/issues/36712&#41;.)
[comment]: <> (This means, that prebuild opus libraries are contained in this package for x86 and x86_64 architectures. They are on runtime copied to a temporary directory using [path_provider]&#40;https://pub.dev/packages/path_provider&#41; and then loaded from there. The contained binaries were build using docker with [`Dockerfile`][2].)
TODO

[1]: ../opus_flutter
[2]: ./Dockerfile