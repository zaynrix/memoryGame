import 'package:flutter/material.dart';

class App {
  late  BuildContext _context;
  late double _height;
  late double _width;
  late double _heightPadding;
 late double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height - ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding = _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}

class Colors {
//  Color _mainColor = Color(0xFFFF4E6A);
  Color _mainColor = Color(0xFF0c7c4c);
  Color _mainDarkColor = Color(0xFF219264);
  Color _secondColor = Color(0xFF818382);
  Color _secondDarkColor = Color(0xFFccccdd);
  Color _accentColor = Color(0xFF0F4530);
  Color _accentDarkColor = Color(0xFF9999aa);
  // Color _scaffoldDarkColor = Color(0xFF2C2C2C);
  Color _scaffoldColor = Color(0xFF265744);

  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }

  Color scaffoldColor(double opacity) {
    return _scaffoldColor.withOpacity(opacity);
  }
}
