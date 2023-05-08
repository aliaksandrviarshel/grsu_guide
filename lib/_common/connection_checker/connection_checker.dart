import 'dart:async';

import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';

import '../dotted_progress_indicator/dotted_progress_indicator.dart';

import 'no_internet_connection_view.dart';

class ConnectionChecker extends StatefulWidget {
  final Widget child;

  const ConnectionChecker({
    super.key,
    required this.child,
  });

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  final _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _connectivity.checkConnectivity(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: DottedProgressIndicator());
        }

        if (snapshot.requireData == ConnectivityResult.none) {
          StreamSubscription? listener;
          listener = _connectivity.onConnectivityChanged.listen((event) {
            if (event != ConnectivityResult.none) {
              listener?.cancel();
              setState(() {});
            }
          });

          return const NoInternetConnectionView();
        }

        return widget.child;
      },
    );
  }
}
