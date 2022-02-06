import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/image_catalog.dart';
import 'models/favorites.dart';

import 'screens/imagegrid.dart';
import 'screens/favorites.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ImageList()),
        ChangeNotifierProvider<FavoriteModel>(
          create: (context) => FavoriteModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Images',
        initialRoute: '/',
        routes: {
          '/': (context) => ImageGrid(),
          '/fav': (context) => Favorites(),
        },
      ),
    );
  }
}
