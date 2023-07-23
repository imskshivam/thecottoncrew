import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc/Screen/HomeScreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [HomeScreen(), HomeScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
          elevation: 2,
          selectedLabelStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false, // Hide selected item label
          showUnselectedLabels: false, // Hide unselected item label
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                height: 25,
                width: 25,
                child: Image.asset(
                  'assets/images/home.png',
                  fit: BoxFit.fill,
                ),
              ),
              label: 'Home', // Label text (hidden)
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 25,
                width: 25,
                child: Image.asset(
                  'assets/images/shopping-cart.png',
                  fit: BoxFit.fill,
                ),
              ),
              label: 'Cart', // Label text (hidden)
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
