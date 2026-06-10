This repo is a demo to test different scenarios where `buildStep.writeAsString` within `PostProcessBuilder` throws an `InvalidOutputException` (`Asset already exists`).

## InvalidOutputException when using PostProcessBuilder and a resolving builder

Reference: https://github.com/dart-lang/build/issues/4975

Reproduction (general):

1. Have a `PostProcessBuilder` that outputs `A.dart`
2. Have a regular Dart file that imports `A.dart`
3. Have a normal `Builder` that analyzes every Dart file
4. Run `dart run build_runner build`
5. See `Asset already exists` error but the file actually doesn't exist

Reproduction by concrete example using this repo:

1. Run the following commands:

```bash
echo "1" > lib/input.txt
dart run build_runner build # Error!
```

2. For `analyzing_builder` set `auto_apply: none`, or remove it completely
3. Run the following commands:

```bash
echo "1" > lib/input.txt
dart run build_runner clean && dart run build_runner build # Works fine!
```

## InvalidOutputException after clean

Reference: https://github.com/dart-lang/build/issues/4402

Reproduction:

1. Remove `analyzing_builder` or set `auto_apply: none`

2. Run the following commands:

```bash
echo "1" > lib/input.txt
dart run build_runner build
rm -rf .dart_tool

dart run build_runner build # Error!
```
