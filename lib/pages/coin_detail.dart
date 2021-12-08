import 'package:cripto_moeda/configs/app_settings.dart';
import 'package:cripto_moeda/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/src/provider.dart';

const _key = '00076bd4';

var request =
    "https://api.hgbrasil.com/finance/stock_price?key=${_key}&symbol=";

Future<Map> getData(String coin) async {
  http.Response response = await http.get(Uri.parse('$request$coin'));
  return json.decode(response.body);
}

class CoinDetailPage extends StatefulWidget {
  Coin coin;
  CoinDetailPage({Key? key, required this.coin}) : super(key: key);

  @override
  _CoinDetailPageState createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage> {
  late NumberFormat real;
  late Map<String, String> loc;

  readFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  @override
  Widget build(BuildContext context) {
    readFormat();
    Coin coin = widget.coin;
    return Scaffold(
        appBar: AppBar(
          title: Text(coin.name),
        ),
        body: FutureBuilder<Map>(
            future: getData(coin.symbol),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Center(
                      child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Colors.purple, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      "Erro ao carregar dados...",
                      style: TextStyle(color: Colors.purple, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    var c = snapshot.data?['results'][coin.symbol];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(24,10,24,24),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Hero(
                              tag: 'icon${c["symbol"]}',
                              child: Image.asset('images/${c["symbol"]}.jpg'),
                            ),
                            width: 100,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${c["symbol"]} - ${c["name"]}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Text('CNPJ ${c["document"]}', style: Theme.of(context).textTheme.bodyText1,),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${c["description"]}',
                                          textAlign: TextAlign.center
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      'Price',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30
                                      )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: Text(
                                      real.format(c["price"]),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45
                                      )
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Text('${c["change_percent"]}%', style: const TextStyle(fontSize: 30),),
                                      ),
                                      Icon((c["change_percent"]>0)?Icons.arrow_upward_outlined:Icons.arrow_downward_outlined, size: 30,)
                                    ],
                                  ),
                                  Padding(padding: EdgeInsetsDirectional.only(top: 10), child: Icon(Icons.timer, size: 50,),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('${c["market_time"]["open"]}h', style: const TextStyle(fontSize: 30),),
                                      const Icon(Icons.lock_open, size: 30,),
                                      const Padding(padding: EdgeInsetsDirectional.all(10)),
                                      Text('${c["market_time"]["close"]}h', style: const TextStyle(fontSize: 30),),
                                      const Icon(Icons.lock_outline, size: 30,)
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
