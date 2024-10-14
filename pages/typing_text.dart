// lib/pages/typing_text.dart

import 'package:flutter/material.dart';
import 'dart:async';

class TypingText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  TypingText({required this.text, required this.textStyle});

  @override
  _TypingTextState createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  String displayedText = '';
  int index = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTyping();
  }

  void startTyping() {
    timer = Timer.periodic(Duration(milliseconds: 180), (timer) {
      if (index < widget.text.length) {
        setState(() {
          displayedText += widget.text[index];
          index++;
        });
      } else {
        // Reset for continuous typing effect
        index = 0;
        displayedText = '';
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayedText,
      style: widget.textStyle,
      textAlign: TextAlign.center,
    );
  }
}
