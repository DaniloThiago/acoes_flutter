import 'package:cripto_moeda/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CoinDetailPage extends StatefulWidget {
  Coin coin;
  CoinDetailPage({ Key? key, required this.coin }) : super(key: key);

  @override
  _CoinDetailPageState createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage> {
  final _form = GlobalKey<FormState>();
  final _value = TextEditingController();
  double amount = 0;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  purchaseCoin() {
    if(_form.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                child: Text('Successfully purchased coin'),
              )
            ],
          ),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Coin coin = widget.coin;
    return Scaffold(
      appBar: AppBar(
        title: Text(coin.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Hero(tag: 'icon${coin.name}', child: Image.asset(coin.icon)),
                    width: 50,
                  ),
                  Container(width: 10,),
                  Text(
                    real.format(coin.price),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),
            (amount > 0)
            ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Text(
                  '$amount ${coin.symbol}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal[700],
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.teal[50]
                ),
              ),
            )
            : Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
            ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _value,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border:  OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    'reais',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})$'))
                ],
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Campo obrigatório';
                  } 
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    amount = (value.isEmpty)
                      ? 0
                      : double.parse(value) / coin.price;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: purchaseCoin,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Comprar',
                        style: TextStyle(fontSize: 20)
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}