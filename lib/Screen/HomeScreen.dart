import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detailscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _heartAnimationController;
  late Animation<Color?> _heartColorAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Initialize the heart animation controller and color animation
    _heartAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heartColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.red,
    ).animate(_heartAnimationController);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Explore \nTrendy Clothes",
                style: GoogleFonts.nunito(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1)),
                child: TabBar(
                  isScrollable: true,
                  indicator: BoxDecoration(
                    color: Colors.black,
                  ),
                  controller: _tabController,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Container(
                          width: 85,
                          child: Center(
                              child: Text(
                            "All",
                            style:
                                GoogleFonts.nunito(fontWeight: FontWeight.bold),
                          ))),
                    ),
                    Tab(
                      child: Container(
                          width: 85,
                          child: Center(
                              child: Text(
                            "Men",
                            style:
                                GoogleFonts.nunito(fontWeight: FontWeight.bold),
                          ))),
                    ),
                    Tab(
                      child: Container(
                          width: 85,
                          child: Center(
                              child: Text(
                            "Tshirt",
                            style:
                                GoogleFonts.nunito(fontWeight: FontWeight.bold),
                          ))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildStaggeredGrid(),
                    buildStaggeredGrid(),
                    buildStaggeredGrid(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStaggeredGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        mainAxisExtent: 300,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.all(10),
        height: 400,
        width: 200,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'image$index', // Provide a unique tag for each image
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.pink.withOpacity(0.1),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              // Pass the image tag and other details to the detail screen
                              tag: 'image$index',
                              imageUrl: "assets/images/girl.png",
                              price: "\$456",
                              description: "Explore Trendy Clothes",
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/images/girl.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      // Trigger the custom heart animation when the icon is tapped
                      _heartAnimationController.forward(from: 0);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AnimatedBuilder(
                        animation: _heartAnimationController,
                        builder: (context, child) {
                          return Icon(
                            Icons.favorite,
                            size: 17,
                            color: _heartColorAnimation.value,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "\$456",
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Explore Trendy Clothes",
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      itemCount: 10, // Total number of grid items
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 40)
      ..lineTo(0, size.height - 40)
      ..cubicTo(0, size.height, 30, size.height, 40, size.height)
      ..lineTo(size.width - 40, size.height)
      ..cubicTo(size.width - 30, size.height, size.width, size.height,
          size.width, size.height - 40)
      ..lineTo(size.width, 40)
      ..cubicTo(size.width, 30, size.width, 0, size.width - 40, 0)
      ..lineTo(40, 0)
      ..cubicTo(30, 0, 0, 0, 0, 40);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
