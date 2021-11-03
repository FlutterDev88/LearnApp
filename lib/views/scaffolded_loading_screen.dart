import 'package:flutter/material.dart';
import 'package:learn_app/constants.dart';

class ScaffoldedLoadingScreen extends StatelessWidget {
  final bool initial;

  ScaffoldedLoadingScreen({this.initial = false}) : super(key: Key('loading'));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final margin = size.width * 0.05;
    final width = size.width * 0.9;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            const CircularProgressIndicator(),
            if (initial) Container(height: kPadding6),
            if (initial)
              Container(
                margin: EdgeInsets.all(margin),
                child: const Text(
                  'Loading! It may take a few seconds.',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: kBodyFontSize3
                  ),
                  textAlign: TextAlign.center,
                ),
                width: width,
              ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
