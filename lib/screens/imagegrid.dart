import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/image_catalog.dart';
import '../models/favorites.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var urlList = context.read<ImageList>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/fav');
              },
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: urlList.getNormalList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) => GridBox(index: index),
        ),
      ),
    );
  }
}

class GridBox extends StatelessWidget {
  GridBox({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    var urlList = context.read<ImageList>();
    var mapped = urlList.getMappedList;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(mapped[index]), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.black87.withOpacity(0.8),
                  Colors.black87.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
          ),
          Positioned(
              child: FavBtn(
            id: index,
          )),
        ],
      ),
    );
  }
}

class FavBtn extends StatelessWidget {
  FavBtn({Key? key, required this.id}) : super(key: key);

  int id;

  @override
  Widget build(BuildContext context) {
    var favList = context.select<FavoriteModel, bool>(
      (x) => x.favUrls.contains(id),
    );

    var watchingList = context.watch<FavoriteModel>();

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 0, 0),
      child: GestureDetector(
        onTap: () {
          favList ? watchingList.remove(id) : watchingList.add(id);
        },
        child: Icon(
          favList ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
      ),
    );
  }
}
