
import 'package:flutter/material.dart';

class ColorizeAnimatedText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final List<Color> colors;
  final Duration speed;
  final TextAlign textAlign;
  final TextDirection textDirection;

  const ColorizeAnimatedText(
    this.text, {
    required this.textStyle,
    required this.colors,
    this.speed = const Duration(milliseconds: 200),
    this.textAlign = TextAlign.start,
    this.textDirection = TextDirection.ltr,
    super.key,
  }) : assert(colors.length > 1);

  @override
  State<ColorizeAnimatedText> createState() => _ColorizeAnimatedTextState();
}

class _ColorizeAnimatedTextState extends State<ColorizeAnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _colorShifter;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.speed * widget.text.length,
      vsync: this,
    )..repeat(reverse: true);

    final colorShift = widget.colors.length * 300.0;
    final colorTween = widget.textDirection == TextDirection.ltr
        ? Tween<double>(begin: 0.0, end: colorShift)
        : Tween<double>(begin: colorShift, end: 0.0);

    _colorShifter = colorTween.animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorShifter,
      builder: (context, child) {
        final shader = LinearGradient(
          colors: widget.textDirection == TextDirection.ltr
              ? widget.colors
              : widget.colors.reversed.toList(),
        ).createShader(
          Rect.fromLTWH(0.0, 0.0, _colorShifter.value, 0.0),
        );

        return Opacity(
          opacity: 1.0,
          child: Text(
            widget.text,
            style:
                widget.textStyle.copyWith(foreground: Paint()..shader = shader),
            textAlign: widget.textAlign,
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
