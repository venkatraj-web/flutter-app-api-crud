import 'package:flutter/material.dart';
import 'package:qikcasual/ui/home_screen.dart';
import 'package:qikcasual/ui/profile_screen.dart';
import 'package:qikcasual/utils/constants.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const Text("Search"),
    const Text("Rewards"),
    const ProfileScreen(),
  ];

  void _onItemTabbed(int index) {
    _pageController.jumpToPage(index);

    // setState(() {
    //   _selectedIndex = index;
    // });
    // print(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0Xff111E28),
        foregroundColor: Colors.white,
        title: Center(child: Text("Qikcasual")),
        actions: [
          IconButton(
            onPressed: () {
              Constants.showLogoutDialog(context);
            },
            icon: Icon(Icons.power_settings_new),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // padding: EdgeInsets.only(right: 10),
            // color: Colors.purple,
            height: 150,
            width: 30,
            child: Stack(
              children: [
                IconButton(
                  // iconSize: 30,
                  alignment: Alignment.center,
                  onPressed: () {
                    Constants.showFlutterToast("Notifiactions", Colors.orange);
                  },
                  icon: Icon(Icons.notifications),
                ),
                Positioned(
                    child: Stack(
                  children: const [
                    Positioned(
                      top: 4.0,
                      right: 0,
                      child: Icon(
                        Icons.brightness_1,
                        size: 15,
                        color: Colors.red,
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedIconTheme: const IconThemeData(
          color: Color(0Xff111E28),
        ),
        onTap: _onItemTabbed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Color(0xFF526480),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search_outlined),
              label: "search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: "rewards"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: "profile"),
        ],
      ),
    );
  }

}
