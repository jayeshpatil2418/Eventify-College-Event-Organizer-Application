// lib/pages/homepage.dart

import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import the Signup Page
import 'login_page.dart';  // Import the Login Page
import 'typing_text.dart'; // Import TypingText if in a separate file

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFF9F3FF), // Set background color
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Typing effect text
              TypingText(
                text: 'Welcome to Eventify!',
                textStyle: TextStyle(
                  fontFamily: 'GoogleSans', // Use Google Sans font
                  fontSize: size.width * 0.09, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3C2473),
                ),
              ),
              SizedBox(height: size.height * 0.1), // Responsive gap

              // Centered image
              Container(
                height: size.height * 0.4, // Responsive height
                width: size.width * 0.8, // Responsive width
                child: Center(
                  child: Transform.translate(
                    offset: Offset(0, -50), // Move the image upward by 50 pixels
                    child: Image.asset('images/homepage.png'), // Use your image path here
                  ),
                ),
              ),

              // Further reduced space between the image and text
              SizedBox(height: size.height * 0.01), // Minimal spacing

              // Introductory line
              Text(
                "Join the fun and effortlessly dive into unforgettable events with Eventify!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.05, // Responsive font size
                  color: Color(0xFF3C2473),
                  fontFamily: 'GoogleSans',
                ),
              ),
              SizedBox(height: size.height * 0.1), // Space below the text

              // Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8B76B9), // Background color
                  fixedSize: Size(size.width * 0.8, 50), // Responsive button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // rounding
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontFamily: 'GoogleSans', // Use Google Sans font
                    color: Colors.white,
                    fontSize: size.width * 0.05, // Responsive font size
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Sign Up Button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFF8B76B9)), // Border color
                  fixedSize: Size(size.width * 0.8, 50), // Responsive button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // rounding
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'GoogleSans', // Use Google Sans font
                    color: Color(0xFF8B76B9),
                    fontSize: size.width * 0.05, // Responsive font size
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
