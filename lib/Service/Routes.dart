import 'package:beamer/beamer.dart';

import 'package:flutter/cupertino.dart';

import '../Pages/example.dart';
import '../Pages/homepage.dart';
import '../Pages/shop_page.dart';

final routerDelegate = BeamerDelegate(
  initialPath: '/home', // Set your initial route path
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/home': (context, state, data) {
        return BeamPage(
          key: const ValueKey("home_page"),
          title: 'Chief Sosa',
          child: HomePage(),
        );
      }, //sunt fullstack acum
      '/example': (context, state, data) {
        return const BeamPage(
          key: ValueKey("example"),
          title: 'Zdroba bss',
          child: ExamplePage(),
        );
      },
      '/shop': (context, state, data) {
        return BeamPage(
          key: ValueKey("shop"),
          title: 'Shop Page',
          child: ShopPage(),
        );
      },
    },
  ),
);
