import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class DottedProgressIndicator extends StatelessWidget {
  const DottedProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        size: 80,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
