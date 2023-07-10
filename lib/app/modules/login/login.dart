import 'package:aplikasi_scanner/app/core/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplikasi_scanner/app/modules/dashboard/dashboard.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscured = true;

  void tokenLogin(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
  final ApiClient _apiClient = ApiClient();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUsers() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.blue.shade300,
      ),
    );

    try {
      Response response = await _apiClient.login(
        emailController.text,
        passwordController.text,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        String accessToken = response.data['data']['accessToken'];
        tokenLogin(accessToken);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DashBoard(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.data['message']}'),
            backgroundColor: Colors.green.shade300,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.data['message']}'),
            backgroundColor: Colors.red.shade300,
          ),
        );
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
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Selamat Datang kembali',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Visby",
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Text(
            'Silahkan login dengan memasukkan username dan kata sandi anda',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: "Visby",
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              label: const Text(
                'Username',
                style: TextStyle(
                  fontFamily: "Visby",
                  color: Colors.black,
                ),
              ),
              hintText: "Username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: passwordController,
            obscureText: _isObscured,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              label: const Text(
                'Kata Sandi',
                style: TextStyle(
                  fontFamily: "Visby",
                  color: Colors.black,
                ),
              ),
              hintText: "Kata Sandi",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              loginUsers();
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const DashBoard(),
              //   ),
              // );
            },
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff5C715E),
              ),
              child: Text(
                'Masuk',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
