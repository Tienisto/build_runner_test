import 'dart:async';

import 'package:build/build.dart';

Builder normalBuilder(BuilderOptions options) {
  return NormalBuilder();
}

class NormalBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final input = await buildStep.readAsString(AssetId(buildStep.inputId.package, 'lib/input.txt'));

    final outputAssetId = AssetId(buildStep.inputId.package, 'lib/intermediate.txt');
    await buildStep.writeAsString(
      outputAssetId,
      input,
    );
    print('Written to $outputAssetId');
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': ['intermediate.txt'],
      };
}
