// Flutter
import 'package:flutter/material.dart';

// Navbar
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

// Local imports
import 'package:harvesthacks2022/constants/colors.dart';

import 'package:harvesthacks2022/widgets/fade_indexed_stack.dart';

import 'package:harvesthacks2022/pages/nav_pages/settings.dart';
import 'package:harvesthacks2022/pages/nav_pages/discover.dart';
import 'package:harvesthacks2022/pages/nav_pages/set_creation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static _HomePageState of(BuildContext context) =>
      context.findAncestorStateOfType<_HomePageState>()!;
}

class _HomePageState extends State<HomePage> {
  var _selectedTabIndex = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTabIndex = i;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Discover(),
    const SetCreationPage(),
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
          // Home
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: GlobalTheme.accent,
          ),

          // Search
          DotNavigationBarItem(
            icon: const Icon(Icons.list),
            selectedColor: GlobalTheme.accent,
          ),

          // Profile
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
