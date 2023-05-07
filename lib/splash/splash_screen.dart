import 'package:flutter/material.dart';

import 'package:grsu_guide/splash/fake_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _paddingTop = 100.0;
  var _progressIndicatorOpacity = 1.0;
  final _progressIndicatorController = ProgressController();

  @override
  Widget build(BuildContext context) {
    // TODO: remove hardcoded delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      _progressIndicatorController.speedUp();
    });

    return Scaffold(
      body: Stack(
        children: [
          AnimatedPadding(
            padding: EdgeInsets.only(top: _paddingTop),
            duration: const Duration(milliseconds: 1000),
            onEnd: () {
              Navigator.pushReplacementNamed(context, '/galleries_map');
            },
            curve: Curves.easeInOut,
            child: Column(
              children: [
                // TODO: optimize image, use only logo itself
                Image.asset('assets/images/splash/logo_large.png'),
                const SizedBox(height: 60),
                AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    opacity: _progressIndicatorOpacity,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: FakeLinearProgressIndicator(
                          controller: _progressIndicatorController,
                          duration: const Duration(seconds: 5),
                          onDone: () {
                            _paddingTop = 200.0;
                            _progressIndicatorOpacity = 0;
                            setState(() {});
                          },
                          color: const Color(0xffA88AFF),
                          backgroundColor: const Color(0x78788033),
                        )
                        // child: FakeLinearProgressIndicator(
                        //   color: Color(0xffA88AFF),
                        //   backgroundColor: Color(0x78788033),
                        // ),
                        )),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/splash/background.png',
                fit: BoxFit.fitWidth,
              )
            ],
          )
        ],
      ),
    );
  }
}
