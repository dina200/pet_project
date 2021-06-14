import 'package:flutter/material.dart';
import 'package:pet_project/application/router/path.dart';

class PetProjectRouteInformationParser extends RouteInformationParser<PetProjectRoutePath> {
  @override
  Future<PetProjectRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    return PetProjectRoutePath.fromUrl(routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(PetProjectRoutePath path) {
    return RouteInformation(location: path.toUrl());
  }
}
