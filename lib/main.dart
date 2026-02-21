import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/core/routes/app_router.dart';
import 'package:movie_omdbid_api/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/presentation/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    BlocProvider(
      create: (context) => MovieBloc(),
      child: const MovieExplorer(),
    ),
  );
}

class MovieExplorer extends StatefulWidget {
  const MovieExplorer({super.key});

  @override
  State<MovieExplorer> createState() => _MovieExplorerState();
}

class _MovieExplorerState extends State<MovieExplorer> {
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
            style: const TextStyle(
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


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: AppRouter.generate,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              IndexedStack(
                index: _currentIndex,
                children: const [
                  HomeScreen(),
                  Center(child: Text('Search Screen')),
                  Center(child: Text('Profile Screen')),
                ],
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  height: 64,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    boxShadow: [
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
                        duration: const Duration(milliseconds: 500),
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
      ),
    );
  }
}
