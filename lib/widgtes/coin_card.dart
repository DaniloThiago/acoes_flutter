import 'package:cripto_moeda/models/coin.dart';
import 'package:cripto_moeda/pages/coin_detail.dart';
import 'package:cripto_moeda/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CoinCard extends StatefulWidget {
  Coin coin;
  CoinCard({Key? key, required this.coin}) : super(key: key);

  @override
  _CoinCardState createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  static Map<String, Color> precoColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.indigo
  };

  openDetail() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => CoinDetailPage(coin: widget.coin)));
  }

  @override
  Widget build(BuildContext context) {
    Coin coin = widget.coin;
    return Card(
      margin: const EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => openDetail(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Hero(
                tag: 'icon${coin.symbol}',
                child: Image.asset(
                  coin.icon,
                  height: 40,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coin.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        coin.symbol,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black45),
                      )
                    ],
                  ),
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: const Text('Remove from favorite'),
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<FavoriteRepository>(context, listen: false).remove(coin);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
