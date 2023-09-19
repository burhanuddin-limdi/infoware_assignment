import 'package:flutter/material.dart';
import 'package:infoware_assignment/pages/form_page.dart';
import 'package:infoware_assignment/pages/movies_page.dart';
import 'package:infoware_assignment/pages/music_page.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List pages = [const MoviesPage(), const FormPage(), const MusicPage()];
  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111827),
      body: pages[selectedIndex],
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: const Color(0xff111827),
        waterDropColor: const Color(0xffff5722),
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.file_copy,
            outlinedIcon: Icons.file_copy_outlined,
          ),
          BarItem(
            filledIcon: Icons.music_note,
            outlinedIcon: Icons.music_note_outlined,
          ),
        ],
      ),
    );
  }
}
