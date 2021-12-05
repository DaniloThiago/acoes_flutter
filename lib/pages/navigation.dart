import 'package:cripto_moeda/pages/home.dart';
import 'package:flutter/material.dart';

import 'favorite.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({ Key? key }) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentpage = 0;
  late PageController pageController;

  @override
  void initState() {    
    super.initState();
    pageController = PageController(initialPage: currentpage);
  }

  setCurrentPage(page) {
    setState(() {
      currentpage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          HomePage(),
          FavoritePage(),
        ],
        onPageChanged: setCurrentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentpage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Coins'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
        onTap: (page) {
          pageController.animateToPage(
            page,
            duration: const Duration(microseconds: 400),
            curve: Curves.ease
          );
        },
        backgroundColor: Colors.purple[600],
        selectedItemColor: Colors.purple[50],
        unselectedItemColor: Colors.purple[300],
      ),
    );
  }
}