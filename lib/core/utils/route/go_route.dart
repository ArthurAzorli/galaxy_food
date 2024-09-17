import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouteUtils {

  static GoRoute buildHorizontalRoute({
    required String path,
    required Widget Function(BuildContext context, GoRouterState state) buildChild,
    bool reverse = false,
    String? restorationId,
    List<RouteBase>? routes}) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        return _buildHorizontalPageTransition(
            state: state,
            child: buildChild(context, state),
            reverse: reverse,
            restorationId: restorationId);
      },
      routes: routes ?? [],
    );
  }

  static Page _buildHorizontalPageTransition({
    required GoRouterState state,
    required Widget child,
    bool reverse = false,
    String? restorationId
  }) {

    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      restorationId: restorationId,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = reverse ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }


  static GoRoute buildFadeRoute({required String path,
    required Widget Function(BuildContext context,GoRouterState state) buildChild}) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        return _buildFadePageTransition(
            state: state, child: buildChild(context, state));
      },
    );
  }

  static Page _buildFadePageTransition({required GoRouterState state, required Widget child, String? restorationId}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      restorationId: restorationId,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }

  static GoRoute buildVerticalRoute({required String path, required Widget Function(BuildContext context,GoRouterState state,) buildChild}) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        return _buildVerticalPageTransition(state: state, child: buildChild(context, state));
      },
    );
  }

  static Page _buildVerticalPageTransition({required GoRouterState state, required Widget child}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
