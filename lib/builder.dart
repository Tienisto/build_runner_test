import 'dart:async';

import 'package:build/build.dart';

Builder analyzingBuilder(BuilderOptions options) {
  return AnalyzingBuilder();
}

class AnalyzingBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    await buildStep.resolver.libraryFor(buildStep.inputId);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    '.dart': ['.g.dart'],
  };
}

Builder preparePostBuilder(BuilderOptions options) {
  return PreparePostBuilder();
}

class PreparePostBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final input = await buildStep.readAsString(
      AssetId(buildStep.inputId.package, 'lib/input.txt'),
    );

    final outputAssetId = AssetId(
      buildStep.inputId.package,
      'lib/intermediate.txt',
    );
    await buildStep.writeAsString(outputAssetId, input);
    print('Written to $outputAssetId');
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    r'$lib$': ['intermediate.txt'],
  };
}

PostProcessBuilder postBuilder(BuilderOptions options) {
  return PostBuilder();
}

class PostBuilder implements PostProcessBuilder {
  @override
  final inputExtensions = ['intermediate.txt'];

  @override
  Future<void> build(PostProcessBuildStep buildStep) async {
    print('Started PostBuilder...');

    final content = await buildStep.readInputAsString();

    final outputAssetId = AssetId(
      buildStep.inputId.package,
      'lib/output.g.dart',
    );
    final outputContent = 'const output = "${content.replaceAll('\n', '')}";';

    await buildStep.writeAsString(outputAssetId, outputContent);

    print('Written to $outputAssetId with content: $outputContent');

    buildStep.deletePrimaryInput();
  }
}
