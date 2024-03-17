import 'package:approvelt/common/error_screen.dart';
import 'package:approvelt/common/loader_screen.dart';
import 'package:approvelt/constants/global_variable.dart';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/home/provider/request_item_provider.dart';
import 'package:approvelt/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerStatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
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
  void initState() {
    // updatecurrentuers
    ref.read(authenticationProvider.notifier).updateCurrentUser();
    ref.read(requestProvider.notifier).updateFetchData();
    super.initState();
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
              ),
              label: '',
            ),
          ],
        ),
        body: pages[_page]);
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/defaultprofile.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.cloud),
                        color: Colors.grey.shade200,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "SIGN OUT",
                    style: TextStyle(
                        letterSpacing: 2, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Synchronization disabled...",
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.delete),
              title: const Text("Clear Data"),
            ),
            ListTile(
              onTap: () => ref.read(authenticationProvider.notifier).signOut(),
              leading: const Icon(Icons.logout),
              title: const Text("Sign Out"),
            ),
            const Divider(),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.search),
              title: const Text("Search"),
            ),
          ],
        ),
      );
}
