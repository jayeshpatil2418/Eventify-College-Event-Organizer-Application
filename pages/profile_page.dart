import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String profileImageUrl =
      'https://example.com/profile_image.png'; // Replace with actual image URL
  final String userName = 'John Doe';
  final String userEmail = 'johndoe@example.com';
  final String userBio = 'Flutter Developer and Tech Enthusiast';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Determine the size based on constraints
              double avatarRadius = constraints.maxWidth * 0.15; // 15% of width
              double fontSizeName = constraints.maxWidth * 0.06; // 6% of width
              double fontSizeEmail = constraints.maxWidth * 0.04; // 4% of width
              double fontSizeBio = constraints.maxWidth * 0.045; // 4.5% of width

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Photo
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                  SizedBox(height: 20),

                  // User Name
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: fontSizeName,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // User Email
                  Text(
                    userEmail,
                    style: TextStyle(
                      fontSize: fontSizeEmail,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),

                  // User Bio
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      userBio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSizeBio,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Edit Profile Button
                  ElevatedButton(
                    onPressed: () {
                      // Add your edit profile functionality here
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
