import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/features/home_screen/home_screen.dart';
import 'package:movie_omdbid_api/models/movie_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MovieModel>? snapshot;
  int _currentIndex = 0;

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 25),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "RedHatDisplay",
              fontWeight: FontWeight.w700,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 3;
    double indicatorWidth = 70;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(index: _currentIndex, children: [
              HomeScreen(),
              Center(child: Text('Search Screen')),
              Center(child: Text('Profile Screen')),
            ]),

            Positioned(
              bottom: 0,
              child: Container(
                height: 64,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff2A0002),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      top: 0,
                      curve: Curves.easeOut,
                      left:
                          itemWidth * _currentIndex +
                          (itemWidth / 2) -
                          (indicatorWidth / 2),
                      child: Container(
                        width: indicatorWidth,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _navItem(
                              icon: Icons.home_rounded,
                              label: "Home",
                              index: 0,
                            ),
                          ),
                          Expanded(
                            child: _navItem(
                              icon: Icons.search_rounded,
                              label: "Search",
                              index: 1,
                            ),
                          ),
                          Expanded(
                            child: _navItem(
                              icon: Icons.person,
                              label: "Profile",
                              index: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
