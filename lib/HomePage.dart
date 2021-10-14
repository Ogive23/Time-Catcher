import 'dart:math';

import 'package:animate_icons/animate_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController scaleAnimationController;
  late AnimationController translateAnimationController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> translateAnimation;
  late double w, h;
  List<Map<String, String>> list = [
    {
      'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
      'image': 'https://cdn.picpng.com/man/icon-man-33232.png',
      'name': 'Mahmoued'
    },
    {
      'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
      'image':
          'https://www.pngall.com/wp-content/uploads/2016/05/Man-PNG-Image.png',
      'name': 'Mohamed'
    },
    {
      'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
      'image':
          'https://img.pngio.com/slide2-menpng-rm-web-lab-men-png-635_540.png',
      'name': 'Ali'
    },
    {
      'identifier': List.generate(10, (index) => Random().nextInt(5)).join(),
      'image': 'https://www.freeiconspng.com/uploads/men-hair-png-33.png',
      'name': 'Ismail'
    },
  ];

  int? selectedIndex;
  @override
  void initState() {
    super.initState();
    scaleAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 500));
    translateAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 500));
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(scaleAnimationController);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      translateAnimation =
          Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-w / 2.5, 0.0))
              .animate(translateAnimationController);
    });
    print('builded');
    scaleAnimationController.forward();
    translateAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    scaleAnimationController.dispose();
    translateAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(

            padding: EdgeInsets.symmetric(horizontal: w/25),child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Friends',
                style: TextStyle(
                    color: Color.fromRGBO(82, 86, 89, 1.0),
                    fontSize: 18),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            child: CarouselSlider(
              options: CarouselOptions(
                height: h / 4,
                aspectRatio: 1.0,
                onPageChanged:
                    selectedIndex == null ? (index, reason) {} : null,
                onScrolled: selectedIndex == null ? (value) {} : null,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: selectedIndex == null ? true : false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                for (int index = 0; index < list.length; index++)
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        selectedIndex = selectedIndex == index ? null : index;
                        print(selectedIndex);
                        // ;
                      });
                      if (selectedIndex == null) {
                        print('here');
                        scaleAnimationController.forward(
                            from: scaleAnimationController.lowerBound);
                        translateAnimationController.forward(
                            from: translateAnimationController.lowerBound);
                      } else {
                        scaleAnimationController.reverse(
                            from: scaleAnimationController.upperBound);
                        translateAnimationController.reverse(
                            from: translateAnimationController.upperBound);
                      }
                      print(scaleAnimation.value);
                    },
                    child: Container(
                      width: w,
                      height: h / 4,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          AnimatedOpacity(
                            opacity: selectedIndex == null ? 0 : 1,
                            duration: Duration(milliseconds: 500),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: w / 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.rotate(
                                    angle: 270,
                                    child: SizedBox(
                                        width: w / 3,
                                        child: IgnorePointer(
                                            ignoring: selectedIndex == null,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  print('pressed');
                                                },
                                                style: ButtonStyle(
                                                    alignment:
                                                        Alignment.centerRight),
                                                child: SizedBox(
                                                    child: Text('Snooze'))))),
                                  ),
                                  SizedBox(
                                      width: w / 2,
                                      child: IgnorePointer(
                                        ignoring: selectedIndex == null,
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            style: ButtonStyle(
                                                alignment:
                                                    Alignment.centerRight),
                                            child: SizedBox(
                                                width: w / 2 - w / 3,
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Schedule Snoozer',
                                                      textAlign:
                                                          TextAlign.center,
                                                    )))),
                                      )),
                                  Transform.rotate(
                                    angle: -270,
                                    child: SizedBox(
                                        width: w / 3,
                                        child: IgnorePointer(
                                          ignoring: selectedIndex == null,
                                          child: ElevatedButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                  alignment:
                                                      Alignment.centerRight),
                                              child: Text('Locate')),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: scaleAnimationController.duration!,
                            transform: Transform.scale(
                              scale: selectedIndex == index
                                  ? scaleAnimation.value
                                  : 1.0,
                            ).transform,
                            child: AnimatedContainer(
                              duration: translateAnimationController.duration!,
                              transform: Transform.translate(
                                offset: selectedIndex == index
                                    ? translateAnimation.value
                                    : Offset(0.0, 0.0),
                              ).transform,
                              curve: Curves.linear,
                              child: Card(
                                color: Colors.transparent,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.brown[100]),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: w / 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              list[index]['name']!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Delius',
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Image.network(
                                        list[index]['image']!,
                                        fit: BoxFit.fitHeight,
                                        width: w / 2,
                                        height: h / 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedOpacity(
                opacity: selectedIndex == null ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: AnimatedContainer(
                  width: selectedIndex == null ? 0 : w / 8,
                  duration: Duration(milliseconds: 500),
                  child: AnimateIcons(
                    startIcon: Icons.favorite_border,
                    endIcon: Icons.favorite,
                    controller: AnimateIconController(),
                    startTooltip: 'Icons.add_circle',
                    endTooltip: 'Icons.add_circle_outline',
                    onStartIconPress: () {
                      print("Clicked on Add Icon");
                      return true;
                    },
                    onEndIconPress: () {
                      print("Clicked on Close Icon");
                      return true;
                    },
                    duration: Duration(milliseconds: 500),
                    startIconColor: Colors.deepPurple[100],
                    endIconColor: Colors.deepPurple[400],
                    clockwise: true,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: selectedIndex == null ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: AnimatedContainer(
                  width: selectedIndex == null ? 0 : w / 8,
                  duration: Duration(milliseconds: 500),
                  child: Icon(
                    Icons.block,
                    color: Colors.red[400],
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: selectedIndex == null ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: AnimatedContainer(
                  width: selectedIndex == null ? 0 : w / 8,
                  duration: Duration(milliseconds: 500),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
