import 'package:flutter/material.dart';

class YoyakuTab {
  final IconData _icon;
  final Widget _tab;
  final String _name;

  bool enabled = true;

  YoyakuTab(this._icon, this._tab, this._name);

  Tab get getHeader => Tab(icon: Icon(_icon));
  Widget get getTab => _tab;
  IconData get getIcon => _icon;
  String get getName => _name;
}
