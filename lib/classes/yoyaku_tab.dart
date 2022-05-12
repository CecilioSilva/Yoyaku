import 'package:flutter/material.dart';

class YoyakuTab {
  final IconData _icon;
  final Widget _tab;

  bool enabled = true;

  YoyakuTab(this._icon, this._tab);

  Tab get getHeader => Tab(icon: Icon(_icon));
  Widget get getTab => _tab;
}
