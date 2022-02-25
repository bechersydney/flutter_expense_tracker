import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveButton extends StatelessWidget {
  final VoidCallback _submitData;
  final String _buttonText;
  const AdaptiveButton(this._submitData, this._buttonText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(_buttonText),
            onPressed: _submitData,
          )
        : ElevatedButton(
            onPressed: _submitData,
            child: Text(_buttonText),
          );
  }
}
