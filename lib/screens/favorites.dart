import 'package:catalog/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'imagegrid.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<FavoriteModel>(
          builder: (context, value, child) => GridView.builder(
            itemCount: value.favUrls.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) =>
                GridBox(index: value.favUrls[index]),
          ),
        ),
      ),
    );
  }
}
