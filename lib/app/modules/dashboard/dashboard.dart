import 'package:aplikasi_scanner/app/models/data_scan.dart';
import 'package:aplikasi_scanner/app/core/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:aplikasi_scanner/app/modules/Scan/scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: const SafeArea(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const Home(),
    const Scanner(),
    History(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          _buildBottomNavigationBarItem(
            Icons.home,
            '',
            'assets/images/home.png',
          ),
          _buildBottomNavigationBarItem(
            Icons.menu_book_outlined,
            '',
            'assets/images/scanning.png',
          ),
          _buildBottomNavigationBarItem(
            Icons.class_,
            '',
            'assets/images/timemachine.png',
          ),
          _buildBottomNavigationBarItem(
            Icons.account_circle,
            '',
            'assets/images/profile.png',
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label, String imagePath) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset(imagePath),
      ),
      label: label,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: const [
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                reverse: true,
                child: Body(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Ferdy Sambo',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(left: 30)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
            ),
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/images/Male.png',
                width: 35,
                height: 35,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 4)),
          Container(
            height: 150,
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/gambar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 8)),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/gambar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 15)),
          Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Event',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Randown Acara',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 21,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                  width: 80,
                  height: 60,
                  decoration: const BoxDecoration(color: null),
                  child: const Image(
                    image: AssetImage("assets/images/Time.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                  width: 80,
                  height: 60,
                  decoration: const BoxDecoration(color: null),
                  child: const Image(
                    image: AssetImage("assets/images/Time.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                  width: 80,
                  height: 60,
                  decoration: const BoxDecoration(color: null),
                  child: const Image(
                    image: AssetImage("assets/images/Time.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                  width: 80,
                  height: 60,
                  decoration: const BoxDecoration(color: null),
                  child: const Image(
                    image: AssetImage("assets/images/Time.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                  width: 80,
                  height: 60,
                  decoration: const BoxDecoration(color: null),
                  child: const Image(
                    image: AssetImage("assets/images/Time.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            width: 313,
            child: Expanded(
              child: Divider(
                color: Colors.black,
                height: 40,
              ),
            ),
          ),
          SizedBox(
            width: 313,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/gmap.png',
                      width: 50,
                      height: 50,
                    ),
                    const Text(
                      'Jln.Jalan Jalan KeArab ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Jarak antara teks dan gambar
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Jarak antara garis dan gambar
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: const SafeArea(
        bottom: false,
        child: Scaner(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Scanner',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class Scaner extends StatelessWidget {
  const Scaner({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Scan Here!',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Image.asset(
                'assets/images/Portrait.png',
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(
          color: Color(0xff5C715E),
          indent: 15,
          endIndent: 15,
          thickness: 1.0,
        ),
        const SizedBox(height: 25),
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Last Scan',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 33,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffDFF2E1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                'No',
                style: TextStyle(
                  color: Color(0xff5C715E),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Username',
                style: TextStyle(
                  color: Color(0xff5C715E),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Customer',
                style: TextStyle(
                  color: Color(0xff5C715E),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Scan Time',
                style: TextStyle(
                  color: Color(0xff5C715E),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        // Container Customer
        SizedBox(
          height: 300,
          child: Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF1F0F0)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          '1',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Testing',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Alpha',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '19.40 P.M',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox()
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF1F0F0)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          '1',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Testing',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Alpha',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '19.40 P.M',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox()
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF1F0F0)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          '1',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Testing',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Alpha',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '19.40 P.M',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox()
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF1F0F0)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          '1',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Testing',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Alpha',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '19.40 P.M',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox()
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF1F0F0)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          '1',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Testing',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Alpha',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '19.40 P.M',
                          style: TextStyle(
                            fontFamily: "Visby",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class History extends StatefulWidget {

  History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final items = ['Item 1', 'Item 2', 'Item 3'];
  final ApiClient _api = ApiClient();

  String? value;
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? token = prefs.getString('token');
    return token;
  }

  void fetchScann() async {
    try{ 
      Response response = await _api.fetchScan(getToken());
      String data = response.data['checked'];
      if(response.statusCode == 200)
      {
        DataScan();
      } else {

      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff5C715E),
          ),
          child: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
        title: Text(
          'History',
          style: GoogleFonts.poppins(
            color: const Color(0xff5C715E),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filter',
                      style: TextStyle(
                        fontFamily: "Visby",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff5C715E),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 27,
                      width: 95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xff5C715E),
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text(
                            'Event',
                            style: TextStyle(
                              fontFamily: "Visby",
                              color: Color(0xff5C715E),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          focusColor: Colors.white,
                          icon: const Icon(
                            CupertinoIcons.chevron_down,
                            size: 10,
                          ),
                          value: value,
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value) {
                            (context as Element).markNeedsBuild();
                            this.value = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filter',
                      style: TextStyle(
                        fontFamily: "Visby",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff5C715E),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return const SafeArea(child: Kalender());
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 27,
                            width: 95,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xff5C715E),
                                )),
                            child: const Text(
                              '31/05/2022',
                              style: TextStyle(
                                fontFamily: "Visby",
                                color: Color(0xff5C715E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: const Text(
                              '-',
                              style: TextStyle(
                                color: Color(0xff5C715E),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 27,
                            width: 95,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xff5C715E),
                                )),
                            child: const Text(
                              '31/05/2022',
                              style: TextStyle(
                                fontFamily: "Visby",
                                color: Color(0xff5C715E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 8),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    size: 15,
                    color: Color(0xff5C715E),
                  ),
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    fontFamily: "Visby",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff5C715E),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff5C715E),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 33,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffDFF2E1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'No',
                    style: TextStyle(
                      color: Color(0xff5C715E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Color(0xff5C715E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Customer',
                    style: TextStyle(
                      color: Color(0xff5C715E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Scan Time',
                    style: TextStyle(
                      color: Color(0xff5C715E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            // Container Customer
            SizedBox(
              height: 500,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF1F0F0)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            '1',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Testing',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alpha',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19.40 P.M',
                            style: TextStyle(
                              fontFamily: "Visby",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontFamily: "Visby",
            color: Color(0xff5C715E),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      );
}

class Kalender extends StatelessWidget {
  const Kalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 5,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                'Date & Time',
                style: TextStyle(
                  fontFamily: "Visby",
                  color: Color(0xff5C715E),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Text(
                'Done',
                style: TextStyle(
                  fontFamily: "Visby",
                  color: Color(0xff17A1FA),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
                onDateChanged: (value) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xffD9D9D9),
              ),
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 14, left: 17),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DashBoard(),
                        ),
                      );
                    },
                    child: Container(
                      height: 29,
                      width: 29,
                      decoration: const ShapeDecoration(
                          color: Color.fromRGBO(92, 113, 94, 1),
                          shape: CircleBorder()),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 10),
                    child: Text(
                      'Profil Saya',
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(92, 113, 94, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Expanded(
              child: Container(
                color: const Color(0xffD9D9D9),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 60, left: 40, bottom: 10),
                            child: Text(
                              "Ferdi Sambo",
                              style: GoogleFonts.poppins(
                                color: const Color.fromRGBO(92, 113, 94, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    onPressed: () async {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        child: Expanded(
                          child: Divider(
                            indent: 30,
                            endIndent: 30,
                            color: Color.fromRGBO(92, 113, 94, 1),
                            height: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 40),
                        child: Text(
                          'Nama CEO',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(92, 113, 94, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25, left: 35),
                              child: Text(
                                'Edit Profil',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff999999),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 25, right: 35),
                              child: Icon(
                                Icons.chevron_right,
                                size: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25, left: 35),
                              child: Text(
                                'Logout',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff999999),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 25, right: 35),
                              child: Icon(
                                Icons.chevron_right,
                                size: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
