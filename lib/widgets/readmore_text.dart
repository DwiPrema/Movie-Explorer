import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';

class ReadmoreText extends StatefulWidget {
  final String text;
  final int trimLines;
  const ReadmoreText({super.key, required this.text, this.trimLines = 2});

  @override
  State<ReadmoreText> createState() => _ReadmoreTextState();
}

class _ReadmoreTextState extends State<ReadmoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final textSpan = TextSpan(
          text: widget.text,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 14,
            height: 1.5,
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: _isExpanded ? null : widget.trimLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraint.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        return GestureDetector(
          onTap: isOverflowing || _isExpanded
              ? () {
                  setState(() => _isExpanded = !_isExpanded);
                }
              : () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.text,
                maxLines: _isExpanded ? null : widget.trimLines,
                overflow: _isExpanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: "RedHatDisplay",
                  fontStyle: FontStyle.italic,
                  color: AppColors.grey,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),

              if (isOverflowing || _isExpanded)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _isExpanded ? "Hide" : "Read more...",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
