
import 'package:flutter/material.dart';
import 'package:formatted_text/formatted_text.dart';
import 'package:qubic_ai/core/utils/extentions/extentions.dart';

class TypewriterAnimatedText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Duration speed;
  final Curve curve;
  final String cursor;
  final TextAlign textAlign;
  final VoidCallback? onComplete;

  const TypewriterAnimatedText(
    this.text, {
    this.textStyle,
    this.speed = const Duration(milliseconds: 2),
    this.curve = Curves.linear,
    this.cursor = '|',
    this.textAlign = TextAlign.start,
    this.onComplete,
    super.key,
  });

  @override
  State<TypewriterAnimatedText> createState() => _TypewriterAnimatedTextState();
}

class _TypewriterAnimatedTextState extends State<TypewriterAnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _typewriterText;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.speed * (widget.text.length + 8),
      vsync: this,
    )..forward().then((_) {
        if (widget.onComplete != null) {
          widget.onComplete!(); // Call the callback when typing is complete
        }
      });

    _typewriterText = CurveTween(curve: widget.curve).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _typewriterText,
      builder: (context, child) {
        final textLen = widget.text.length;
        final typewriterValue = (_typewriterText.value * (textLen + 8)).round();

        bool showCursor = true;
        String visibleString = widget.text;
        if (typewriterValue == 0) {
          visibleString = '';
          showCursor = false;
        } else if (typewriterValue > textLen) {
          showCursor = (typewriterValue - textLen) % 2 == 0;
        } else {
          visibleString = widget.text.substring(0, typewriterValue);
        }
        return TextSelectionTheme(
          data: context.theme.textSelectionTheme,
          child: SelectionArea(
            child: FormattedText(
              visibleString + (showCursor ? widget.cursor : ''),
              style: widget.textStyle,
              textAlign: widget.textAlign,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
