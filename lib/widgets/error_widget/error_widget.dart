import 'package:flutter/material.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

class ErrorPage extends StatelessWidget {
  final String errMsg;
  const ErrorPage({super.key, required this.errMsg});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/ilustration.png",
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            const SizedBox(height: 50),
            title(errMsg),
          ],
        ),
      ),
    );
  }
}
