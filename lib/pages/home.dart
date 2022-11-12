import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:harvesthacks2022/constants/colors.dart';

import 'nav_pages/account_and_settings.dart';
import 'nav_pages/discover.dart';
import 'nav_pages/my_sets.dart';
import '../widgets/fade_indexed_stack.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unflash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => __HomePageState();
}

class __HomePageState extends State<_HomePage> {
  var _selectedTabIndex = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTabIndex = i;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Discover(),
    const MySets(),
    const AccountSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called

    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: DotNavigationBar(
        enablePaddingAnimation: true,
        currentIndex: _selectedTabIndex,
        onTap: _handleIndexChanged,
        dotIndicatorColor: Colors.black,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: GlobalTheme.accent,
          ),

          /// Search
          DotNavigationBarItem(
            icon: const Icon(Icons.list),
            selectedColor: GlobalTheme.accent,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: const Icon(Icons.settings),
            selectedColor: GlobalTheme.accent,
          ),
        ],
      ),
      // make sure state is kept when switching pages
      body: FadeIndexedStack(
        index: _selectedTabIndex,
        children: _widgetOptions,
      ),
    );
  }
}

// enum _SelectedTab { home, favorite, search, person }
