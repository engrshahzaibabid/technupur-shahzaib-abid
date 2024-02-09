import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shahzaib_abid/src/features/home/components/home_tab.dart';
import '../../../../main.dart';
import '../../../constants/asset_string.dart';
import '../../../constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String? initialMessage;

  final List<Widget> _screens = [
    HomeTab(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  Widget buildNavItem(int index, String svgAsset, String tabName) {
    return InkWell(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 6.2,
        child: SvgPicture.asset(svgAsset, height: 25,
          colorFilter: ColorFilter.mode(
              _currentIndex == index ? Colors.white : Colors.white.withOpacity(0.4),
              BlendMode.srcIn),),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 15 + mediaQuery.padding.bottom),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(
              0,
              AssetString.home,
              'Home',
            ),
            buildNavItem(
              1,
              AssetString.home,
              'Browse',
            ),
            buildNavItem(
              2,
              AssetString.home,
              'Orders',
            ),
            buildNavItem(
              3,
              AssetString.home,
              'Inbox',
            ),
            buildNavItem(
              4,
              AssetString.home,
              'Account',
            ),
          ],
        ),
      ),
    );
  }
}
