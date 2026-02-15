import 'dart:async';

import 'package:build/build.dart';

Builder normalBuilder(BuilderOptions options) {
  return NormalBuilder();
}

class NormalBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final outputAssetId = AssetId(buildStep.inputId.package, 'lib/sample.txt');
    await buildStep.writeAsString(
      outputAssetId,
      'Hello World',
    );
    print('Written to $outputAssetId');
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': ['sample.txt'],
      };
}
