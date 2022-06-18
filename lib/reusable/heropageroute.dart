import 'package:flutter/material.dart';

class HeroPageRoute<T> extends PageRoute<T> {
  HeroPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullScreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullScreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => "testing 1234";

  @override
  bool get barrierDismissible => true;

  Widget buildTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation,Widget child) {
    return child;
  }
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(microseconds: 300);
}
