// Created by AMIT JANGID on 18/08/20.

import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final bool isEnabled, isUpperCase;

  CustomButton({
    this.isEnabled = true,
    this.borderRadius = 24,
    this.isUpperCase = true,
    this.margin = const EdgeInsets.only(top: 20),
    @required this.text,
    @required this.onPressed,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
      child: Container(
        margin: widget.margin,
        width: double.infinity,
        child: RaisedButton(
          onPressed: widget.isEnabled ? widget.onPressed : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius)),
          child: Text(
            widget.isUpperCase ? widget.text.toUpperCase() : widget.text,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}
