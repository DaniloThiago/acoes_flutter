import 'package:cripto_moeda/models/coin.dart';
import 'package:cripto_moeda/pages/coin_detail.dart';
import 'package:cripto_moeda/repositories/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final coins = CoinRepository.coins;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Coin> selectedCoin = [];

  showDetails(Coin coin) {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (_) => CoinDetailPage(coin: coin),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cripto Moedas'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int idx) {
            Coin coin = coins[idx];
            return ListTile(
              leading:  (selectedCoin.contains(coin)
                ? const CircleAvatar(
                  child: Icon(Icons.check),)
                : SizedBox(
                  child: Hero(tag: 'icon'+coin.name, child: Image.asset(coin.icon)),
                  width: 40,)
              ),
              title: Text(
                coin.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
              ),
              trailing: Text(real.format(coin.price)),
              selected: selectedCoin.contains(coin),
              selectedTileColor: Colors.purple[50],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
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
          itemCount: coins.length
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.search),
      ),
    );
  }
}
