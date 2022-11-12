import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:harvesthacks2022/screens/nav_pages/account_and_settings.dart';
import 'package:harvesthacks2022/screens/nav_pages/discover.dart';
import 'package:harvesthacks2022/screens/nav_pages/my_sets.dart';
import 'package:harvesthacks2022/widgets/fade_indexed_stack.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UnFlash',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'UnFlash'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            selectedColor: Colors.purple,
          ),

          /// Search
          DotNavigationBarItem(
            icon: const Icon(Icons.list),
            selectedColor: Colors.orange,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: const Icon(Icons.person),
            selectedColor: Colors.teal,
          ),
        ],
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
