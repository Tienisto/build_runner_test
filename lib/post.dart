import 'package:build/build.dart';

PostProcessBuilder postBuilder(BuilderOptions options) {
  return PostBuilder();
}

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