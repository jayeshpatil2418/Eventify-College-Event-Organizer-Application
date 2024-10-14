import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'profile_page.dart'; // Import ProfilePage
import 'home_page.dart'; // Import HomePage (Assuming you have a HomePage)

class ExplorePage extends StatefulWidget {
  final String username;

  ExplorePage({required this.username});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _selectedIndex = 0; // Variable to keep track of the selected index

  // Function to get greeting based on time
  String getGreeting() {
    DateTime now = DateTime.now().toUtc().add(Duration(hours: 5, minutes: 30));
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  // Custom isSameDay method to compare two DateTime objects
  bool isSameDay(DateTime? day1, DateTime day2) {
    if (day1 == null) return false;
    return day1.year == day2.year && day1.month == day2.month && day1.day == day2.day;
  }

  // Build the horizontal calendar UI
  Widget buildHorizontalCalendar() {
    int daysInMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;
    List<DateTime> daysOfMonth = List.generate(daysInMonth, (index) {
      return DateTime(_focusedDay.year, _focusedDay.month, index + 1);
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: daysOfMonth.map((day) {
          bool isSelected = isSameDay(_selectedDay, day);
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDay = day;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF3C2473) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('d').format(day),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat('EEE').format(day),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Function to show profile options
  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('View Profile'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to ProfilePage
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _logout(); // Call the logout function
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Logout function
  void _logout() {
    // Clear user data if necessary
    // For example: await UserPreferences.clear();

    // Navigate back to the home page and clear the navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Replace with your actual home page
          (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  // Function to show scrollable year picker
  void _showYearPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        int currentYear = _focusedDay.year;
        List<int> years = List.generate(86, (index) => 2015 + index);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Year',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: years.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(years[index].toString()),
                    onTap: () {
                      setState(() {
                        _focusedDay = DateTime(years[index], _focusedDay.month, 1);
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to show scrollable month picker
  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        List<String> months = List.generate(12, (index) => DateFormat('MMMM').format(DateTime(0, index + 1)));

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Month',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: months.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(months[index]),
                    onTap: () {
                      setState(() {
                        _focusedDay = DateTime(_focusedDay.year, index + 1, 1);
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to handle back navigation
  Future<bool> _onWillPop() async {
    // Prevent back navigation from ExplorePage
    return false; // Return false to prevent back navigation
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _onWillPop, // Intercept back button
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.05),

              // Greeting and Profile Picture Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, ${widget.username}',
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        getGreeting(),
                        style: TextStyle(
                          fontSize: size.width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _showProfileOptions(context);
                    },
                    child: CircleAvatar(
                      radius: size.width * 0.07,
                      backgroundImage: AssetImage('images/profile_image.png'), // Replace with actual image
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  hintText: 'Search Events',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),

              // Current Selected Date (Tap to change year or month)
              Row(
                children: [
                  GestureDetector(
                    onTap: _showMonthPicker,
                    child: Text(
                      DateFormat('MMMM').format(_focusedDay),
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(' '),
                  GestureDetector(
                    onTap: _showYearPicker,
                    child: Text(
                      DateFormat(' yyyy').format(_focusedDay),
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),

              // Horizontal Calendar
              Container(
                height: size.height * 0.1,
                child: buildHorizontalCalendar(),
              ),

              // Today’s Events Section
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today’s Events (8)',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to See All Events page
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              // Add content like event cards or lists below
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            // Navigate to the corresponding page if needed
          },
        ),
      ),
    );
  }
}
