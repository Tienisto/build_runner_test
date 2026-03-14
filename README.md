This repo is a demo for a possible bug that `buildStep.writeAsString` within `PostProcessBuilder` still
throws an `InvalidOutputException` (`Asset already exists`) although `--delete-conflicting-outputs` is used.

Reference: https://github.com/dart-lang/build/issues/4402

Reproduction:

```bash
dart run build_runner build
rm -rf .dart_tool
dart run build_runner build --delete-conflicting-outputs
```
