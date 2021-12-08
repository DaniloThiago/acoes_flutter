import 'package:cripto_moeda/configs/app_settings.dart';
import 'package:cripto_moeda/models/coin.dart';
import 'package:cripto_moeda/pages/coin_detail.dart';
import 'package:cripto_moeda/repositories/coin_repository.dart';
import 'package:cripto_moeda/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final coins = CoinRepository.coins;
  late NumberFormat real;
  late Map<String, String> loc;
  List<Coin> selectedCoin = [];
  late FavoriteRepository favorites;

  readFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['name'] == 'R\$' ? '\$' : 'R\$';
  
    return PopupMenuButton(
      icon: const Icon(Icons.language),
      itemBuilder: (context) => [
          PopupMenuItem(child: ListTile(
            leading: const Icon(Icons.swap_vert),
            title: Text(locale),
            onTap: () {
              context.read<AppSettings>().setLocale(locale, name);
              Navigator.pop(context);
            },
          ),)
      ],
    );
  }

  appBarDinamic() {
    if(selectedCoin.isEmpty) {
      return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Ações')],
        ),
        actions: [changeLanguageButton()],
        automaticallyImplyLeading: false,
      );
    } else {
      return AppBar(
          leading:  IconButton(icon: const Icon(Icons.close),
          onPressed: () {
            clearSelected();
          },
        ),
        automaticallyImplyLeading: false,
        title: Text('${selectedCoin.length} seletec'),
        backgroundColor: Colors.purple[200],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 20
        ),
      );
    }
  }

  floatingActionButtonDinamic() {
    if(selectedCoin.isEmpty) {
      return FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.search),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: () {
          favorites.saveAll(selectedCoin);
          clearSelected();
        },
        icon: const Icon(Icons.favorite),
        label: const Text(
          'Favorito',
          style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.bold
          ),
        )
      );
    }
  }

  showDetails(Coin coin) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CoinDetailPage(coin: coin),
      ),
    );
  }

  clearSelected() {
    setState(() {
      selectedCoin = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // favorites = Provider.of<FavoriteRepository>(context);
    favorites = context.watch<FavoriteRepository>();
    readFormat();

    return Scaffold(
      appBar: appBarDinamic(),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int idx) {
            Coin coin = coins[idx];
            return
             ListTile(
              leading: (
                selectedCoin.contains(coin)
                ? const CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Hero(
                    tag: 'icon${coin.symbol}',
                    child: Image.asset(coin.icon)),
                    width: 40,
                  )
                ),
              title: Row(
                children: [
                  Text(
                    coin.name,
                    style:const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  if(favorites.list.contains(coin))
                    Icon(Icons.favorite, color: Colors.purple[800], size: 8,),
                ]
              ),
              trailing: Text(real.format(coin.price)),
              selected: selectedCoin.contains(coin),
              selectedTileColor: Colors.purple[50],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              onLongPress: () {
                setState(() {
                  (selectedCoin.contains(coin))
                      ? selectedCoin.remove(coin)
                      : selectedCoin.add(coin);
                });
              },
              onTap: () => showDetails(coin),
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: coins.length),
      floatingActionButton: floatingActionButtonDinamic(),
    );
  }
}
