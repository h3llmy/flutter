import 'package:flutter/material.dart';

class NavigationMiddleware extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    // Add your middleware logic here before the route is pushed
    print('Route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // Add your middleware logic here before the route is popped
    print('Route popped: ${route.settings.name}');
  }

  // You can override other methods like didReplace, didRemove, etc.
}
