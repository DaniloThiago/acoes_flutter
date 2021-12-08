import 'package:cripto_moeda/models/coin.dart';

class CoinRepository {
  static List<Coin> coins = [
    Coin(icon: 'images/RRRP3.jpg', name: '3 R Petroleum', symbol: 'RRRP3', price: 15500.91 ),
    Coin(icon: 'images/TTEN3.jpg', name: '3tentos', symbol: 'TTEN3', price: 15500.92 ),
    Coin(icon: 'images/EALT3.png', name: 'Aco Altona 3', symbol: 'EALT3', price: 15500.93 ),
    Coin(icon: 'images/EALT3.png', name: 'Aco Altona 4', symbol: 'EALT4', price: 15500.94 ),
    Coin(icon: 'images/AERI3.jpg', name: 'Aeris', symbol: 'AERI3', price: 15500.95 ),
  ];
}