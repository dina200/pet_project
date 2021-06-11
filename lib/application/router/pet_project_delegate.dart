import 'package:flutter/material.dart';
import 'package:pet_project/presentation/pages/detail_page.dart';
import 'package:pet_project/presentation/pages/my_home_page.dart';

class PetProjectRoutePath {
  final String path;

  PetProjectRoutePath.home() : path = 'home';

  PetProjectRoutePath.details() : path = 'details';

  PetProjectRoutePath.unknown() : path = 'unknown';

  bool get isHomePage => path == 'home';

  bool get isDetailsPage => path == 'details';
}

class PetProjectRouteInformationParser extends RouteInformationParser<PetProjectRoutePath> {
  @override
  Future<PetProjectRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    print('uri.pathSegments');
    print(uri.pathSegments);
    if (uri.pathSegments.length == 0) {
      return PetProjectRoutePath.home();
    } else if (uri.pathSegments.first == 'details') {
      return PetProjectRoutePath.details();
    }
    return PetProjectRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(PetProjectRoutePath path) {
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/details');
    }
    return RouteInformation(location: '/404');
  }
}

class PetProjectDelegate extends RouterDelegate<PetProjectRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PetProjectRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  bool detailPage = false;

  PetProjectDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('home'),
          child: MyHomeScreen(_handleBookTapped),
        ),
        if (detailPage)
          MaterialPage(
            key: ValueKey('details'),
            child: DetailScreen(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        detailPage = false;
        notifyListeners();
        return true;
      },
    );
  }

  void _handleBookTapped() {
    detailPage = true;
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(PetProjectRoutePath configuration) async {
    if (configuration.isDetailsPage) {
      detailPage = true;
    } else {
      detailPage = false;
    }
  }
}

class PetProjectBackButtonDispatcher extends RootBackButtonDispatcher {
  final PetProjectDelegate _routerDelegate;

  PetProjectBackButtonDispatcher(this._routerDelegate) : super();

  Future<bool> didPopRoute() {
    return _routerDelegate.popRoute();
  }
}


