import 'package:approvelt/constants/global_variable.dart';
import 'package:approvelt/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const Text("Me"),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      drawer: _drawer(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: GlobalVariables.backgroundColor,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_2_outlined),
              // child: const badges.Badge(
              //   badgeStyle: badges.BadgeStyle(
              //     badgeColor: Colors.white,
              //     elevation: 0,
              //   ),
              //   badgeContent: Text('2'),
              //   child: Icon(Icons.person_2_outlined),
              // ),
            ),
            label: '',
          ),
        ],
      ),
      body: pages[_page],
    );
  }

  _appbar(BuildContext context) => AppBar(
        title: Text(
          "My Requests",
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.mode_night,
              size: 30,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      );

  _drawer(BuildContext context) => Drawer(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(gradient: orangeGradient),
              padding: EdgeInsets.only(left: 15, right: 15, top: 40),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/defaultprofile.png')),
                        SizedBox(
                          width: 10,
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.cloud),
                          color: Colors.grey.shade200,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "SIGN IN",
                    style: TextStyle(
                        letterSpacing: 2, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Synchronization disabled...",
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.delete),
              title: Text("Clear Data"),
            ),
            Divider(),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.search),
              title: Text("Search"),
            ),
          ],
        ),
      );
}
