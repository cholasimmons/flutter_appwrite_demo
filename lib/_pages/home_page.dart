import 'package:appwrite_demo/_pages/pageview_home.dart';
import 'package:appwrite_demo/_pages/pageview_settings.dart';
import 'package:appwrite_demo/_pages/pageview_users.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _pageNumber = 0;

  late final PageController _pageView;

  @override
  void initState() {
    super.initState();
    _pageView = PageController(
      initialPage: _pageNumber,
      keepPage: true,
    );
  }

  void onDestroy() {
    super.dispose();
    _pageView.dispose();
  }

  _changePage(int pg) {
    setState(() {
      _pageNumber = pg;
    });
    _pageView.animateToPage(pg,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutExpo);
  }

  // Lower navigation FAB's
  Widget _buildBottomFAB(int pageN) {
    return AnimatedScale(
      scale: _pageNumber == pageN ? 1.0 : 0.7,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutBack,
      child: FloatingActionButton(
        shape: _pageNumber == pageN ? null : const CircleBorder(),
        disabledElevation: 0,
        elevation: 0,
        onPressed: () {
          _changePage(pageN);
        },
        backgroundColor:
            _pageNumber == pageN ? null : Colors.indigo.withOpacity(0.2),
        child: Icon(
          pageN == 0
              ? Icons.home
              : pageN == 1
                  ? Icons.group
                  : Icons.settings,
          color: _pageNumber == pageN
              ? Colors.black
              : Colors.black26.withOpacity(0.4),
        ),
      ),
    );
  }

  _showDialog(String msg) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shadowColor: Colors.black54,
              backgroundColor: Colors.transparent,
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  msg,
                  style: const TextStyle(fontSize: 14),
                ),
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: SafeArea(
      top: true,
      child: Stack(children: [
        PageView(
            controller: _pageView,
            scrollDirection: Axis.horizontal,
            physics:
                const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            onPageChanged: (value) {
              _pageNumber = value;
            },
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            children: const [PageHome(), PageUsers(), PageProfile()]),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      iconSize: 32,
                      onPressed: () {
                        _showDialog('kukonda vo tinika tinika!');
                      },
                      icon: const Icon(Icons.menu)),
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                      iconSize: 32,
                      onPressed: () {
                        _showDialog('Mwaendako na kuChurch!');
                      },
                      icon: const Icon(Icons.search)),
                ],
              ),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBottomFAB(0),
                _buildBottomFAB(1),
                _buildBottomFAB(2),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
