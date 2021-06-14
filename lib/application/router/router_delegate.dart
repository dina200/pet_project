import 'package:flutter/material.dart';
import 'package:pet_project/application/router/path.dart';
import 'package:pet_project/presentation/pages/detail_page.dart';
import 'package:pet_project/presentation/pages/my_home_page.dart';

class PetProjectDelegate extends RouterDelegate<PetProjectRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PetProjectRoutePath> {
  final GlobalKey<NavigatorState> _navigatorKey;
  PetProjectRoutePath _currentConfiguration;

  PetProjectDelegate()
      : _navigatorKey = GlobalKey<NavigatorState>(),
        _currentConfiguration = HomeRoutePath();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  PetProjectRoutePath get currentConfiguration => _currentConfiguration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
       pages: [
        MyHomePage(
          (path) {
            setNewRoutePath(path);
            notifyListeners();
          },
        ),
         if (currentConfiguration is DetailRoutePath)
           DetailPage(),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _currentConfiguration = const HomeRoutePath();
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PetProjectRoutePath configuration) async {
    _currentConfiguration = configuration;
  }
}


