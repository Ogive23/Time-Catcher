import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:time_catcher/HomePage.dart';

import 'QRCodePage.dart';
import 'SearchResultPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double w, h;
  late Channel? channel;
  int selectedPage = 1;
  bool isSearching = false;

  TextEditingController searchText = new TextEditingController();
  @override
  void initState() {
    super.initState();
    // initPusher();
  }

  Future<void> initPusher() async {
    try {
      PusherOptions options = PusherOptions(cluster: "eu");
      PusherClient pusher =
          PusherClient("735d7cb676d3c3280740", options, autoConnect: true);
      pusher.connect();
      channel = pusher.subscribe('test');
      channel!.bind('test', (event) {
        print(event);
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  test() {
    if (channel != null) {
      print('here');
      channel!.trigger("test", {"ha": "ha"});
    }
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    // test();
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            // bottom: PreferredSize(child: SizedBox(height: h/20,), preferredSize: Size(0,h/20)),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(30),
            // ),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(), reverse: true,
              // physics: isSearching? NeverScrollableScrollPhysics(): null,
              child: Row(
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: isSearching ? 0.0 : 1.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE, MMMM dd').format(DateTime.now()),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                              fontSize: 16),
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: Color.fromRGBO(82, 86, 89, 1.0),
                              fontSize: 32),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(width: w,child: TextField()),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    child: TextField(
                      controller: searchText,
                      onChanged: (value) {
                        setState(() {
                          searchText.text = value;
                          searchText.selection = TextSelection.fromPosition(
                              TextPosition(offset: searchText.text.length));
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter #user identifier',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey)),
                    ),
                    width: isSearching ? w - w / 5 - w / 5 : 0,
                  ),
                ],
              ),
            ),
            actions: [
              AnimateIcons(
                startIcon: Icons.search,
                endIcon: Icons.close,
                controller: AnimateIconController(),
                onStartIconPress: () {
                  setState(() {
                    isSearching = !isSearching;
                    if (!isSearching) searchText.clear();
                  });
                  return true;
                },
                onEndIconPress: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                  return true;
                },
                duration: Duration(milliseconds: 500),
                startIconColor: Color.fromRGBO(82, 86, 89, 1.0),
                endIconColor: Colors.red[200],
                clockwise: true,
              ),
              IconButton(
                icon: Icon(
                  Icons.qr_code,
                  color: Color.fromRGBO(82, 86, 89, 1.0),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodePage(),));
                  },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              HomePage(),
              if (isSearching)
                AnimatedOpacity(
                    opacity:
                        isSearching && searchText.text.isNotEmpty ? 1.0 : 0,
                    duration: Duration(milliseconds: 500),
                    child: SearchResultPage(
                      searchText: searchText.text,
                    ))
              else
                SizedBox(),
            ],
          ),
          bottomNavigationBar: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  onTap: (value) {
                    setState(() {
                      selectedPage = value;
                    });
                  },
                  currentIndex: selectedPage,
                  unselectedItemColor: Colors.grey.withOpacity(0.5),
                  fixedColor: Colors.pink,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_border),
                        activeIcon: Icon(Icons.favorite),
                        label: 'Favourites'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.block), label: 'Blocked'),
                  ])),
        ),
      ),
    );
  }
}
