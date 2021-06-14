abstract class PetProjectRoutePath {
  String toUrl();

  factory PetProjectRoutePath.fromUrl(String? url) {
    if (url == null) {
      return const UnknownRoutePath();
    }

    final uri = Uri.parse(url);
    if (uri.pathSegments.isEmpty) {
      return const HomeRoutePath();
    } else if (uri.pathSegments.first == 'detail') {
      return const DetailRoutePath();
    }
    return const UnknownRoutePath();
  }
}

class HomeRoutePath implements PetProjectRoutePath {
  const HomeRoutePath();

  @override
  String toUrl() => '/';
}

class DetailRoutePath implements PetProjectRoutePath {
  const DetailRoutePath();

  @override
  String toUrl() => '/detail';
}

class UnknownRoutePath implements PetProjectRoutePath {
  const UnknownRoutePath();

  @override
  String toUrl() => '/404';
}
