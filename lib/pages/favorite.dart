import 'package:cripto_moeda/repositories/favorite_repository.dart';
import 'package:cripto_moeda/widgtes/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Favorite')],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          color: Colors.indigo.withOpacity(0.05),
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(12),
          child: Consumer<FavoriteRepository>(
            builder: (context, favorites, child) {
              return favorites.list.isEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                          Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(
                            "Nothing favorite",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ])
                  : ListView.builder(
                      itemCount: favorites.list.length,
                      itemBuilder: (_, idx) {
                        return CoinCard(coin: favorites.list[idx]);
                      });
            },
          )),
    );
  }
}
