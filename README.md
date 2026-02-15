This repo is a demo for a possible bug that `buildStep.writeAsString` within `PostProcessBuilder` does not produce any file,
even though the method is called and the content is printed in the console.

Reference: https://github.com/dart-lang/build/issues/4364

```dart
class PostBuilder implements PostProcessBuilder {
  @override
  final inputExtensions = ['sample.txt'];

  @override
  Future<void> build(PostProcessBuildStep buildStep) async {
    print('Started PostBuilder...');

    final content = await buildStep.readInputAsString();

    final outputAssetId = AssetId(buildStep.inputId.package, 'lib/sample_upper.txt');
    final outputContent = content.toUpperCase();

    // Does not produce any file.
    await buildStep.writeAsString(
      outputAssetId,
      outputContent,
    );

    print('Written to $outputAssetId with content: $outputContent');

    buildStep.deletePrimaryInput();
  }
}
```