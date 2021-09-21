import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WaitScreen extends StatelessWidget {
  final isError;
  const WaitScreen({@required this.isError, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: const Color.fromRGBO(0, 10, 30, 100),
        child: Column(
          children: [
            isError
                ? Lottie.asset('assets/images/error.json')
                : Lottie.asset('assets/images/boom.json'),
            isError
                ? AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Server connection problem'),
                      RotateAnimatedText('Please try again.')
                    ],
                    isRepeatingAnimation: true,
                  )
                : AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Please wait!'),
                      RotateAnimatedText('Thankyou.')
                    ],
                    isRepeatingAnimation: true,
                  )
          ],
        ),
      ),
    );
  }
}
