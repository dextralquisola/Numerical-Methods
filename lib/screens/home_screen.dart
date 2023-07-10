import 'package:flutter/material.dart';
import 'package:numerical_project/models/menu.dart';
import 'package:numerical_project/widgets/quotes_widget.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../widgets/menu_widget.dart';
import '../widgets/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // spacing for title should be 26% of the biggest height of appbar

  late AnimationController _animationController;
  late Animation animation;

  final menuItems = [
    MenuItem(title: "", description: "", route: ""),
    MenuItem(
      title: "Bisection Method",
      description: "Bracket method for finding roots of a polynomial",
      route: "/bisection",
    ),
    MenuItem(
      title: "False Position Method",
      description: "Bracket method for finding roots of a polynomial",
      route: "/false-position",
    ),
    MenuItem(
      title: "Newton Raphson Method",
      description: "Open method for finding roots of a polynomial",
      route: "/newton-raphson",
    ),
    MenuItem(
      title: "Secant Method",
      description: "Open method for finding roots of a polynomial",
      route: "/secant",
    ),
    MenuItem(
      title: "Jacobi Method",
      description: "Finding the solution of a system of linear equations",
      route: "/jacobi",
    ),
    MenuItem(
      title: "IEEE754 Format Converter",
      description: "Converting decimal numbers to IEEE754 format",
      route: "/ieee754",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 1, end: 0).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    var dateTime = DateTime.now();
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 240,
                floating: true,
                snap: true,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  var top = constraints.biggest.height;
                  if (constraints.biggest.height == 56) {
                    _animationController.reverse();
                  } else if (constraints.biggest.height > 76) {
                    _animationController.forward();
                  }
                  return FlexibleSpaceBar(
                    title: top ==
                                MediaQuery.of(context).padding.top +
                                    kToolbarHeight ||
                            constraints.biggest.height > 56 &&
                                constraints.biggest.height <= 76
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const AppText(
                                text: "Numerical",
                                textColor: Colors.white,
                                textSize: 20,
                              ),
                              popUpMenuButton(),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                text: dateTime.hour < 12
                                    ? 'Good Morning,'
                                    : dateTime.hour < 18
                                        ? 'Good Afternoon,'
                                        : 'Good Evening,',
                                textColor: Colors.white,
                                textSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              AppText(
                                text: appState.name,
                                textColor: Colors.white,
                                textSize: 24,
                              ),
                            ],
                          ),
                    titlePadding:
                        const EdgeInsets.only(left: 10.0, bottom: 16.0),
                    background: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          color: Colors.deepPurple,
                        ),
                        Positioned(
                          top: 0,
                          right: 1,
                          child: popUpMenuButton(),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
            body: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5.0),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: FadeTransition(
                          opacity: _animationController,
                          child: SizedBox(
                            height: 75,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(40.0),
                                    bottomLeft: Radius.circular(40.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: _animationController,
                        child: const QuotesCard(),
                      )
                    ],
                  );
                }
                return MenuWidget(
                  menuItem: menuItems[index],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "/calculator-screen");
            },
            child: const Icon(
              Icons.calculate_rounded,
            ),
          )),
    );
  }

  Widget popUpMenuButton() {
    return PopupMenuButton(
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
        size: 30,
      ),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.settings, color: Colors.deepPurple),
                SizedBox(width: 5),
                AppText(text: "Preferences"),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info, color: Colors.deepPurple),
                SizedBox(width: 5),
                AppText(text: "About Us"),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) async {
        if (value == 0) {
          await Navigator.pushNamed(context, "/preferences");
        } else if (value == 1) {
          await Navigator.pushNamed(context, "/about-us");
        }
      },
    );
  }
}
