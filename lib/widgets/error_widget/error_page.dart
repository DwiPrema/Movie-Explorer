import 'package:flutter/material.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

class ErrorPage extends StatelessWidget {
  final String errMsg;
  const ErrorPage({super.key, required this.errMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset(
          "assets/images/ilustration.png",
          width: MediaQuery.of(context).size.width * 0.8,
        ),),
        const SizedBox(height: 50),
        title(errMsg),
      ],
    );
  }
}
