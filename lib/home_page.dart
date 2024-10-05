import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'complaint_form_page.dart';
import 'complaint_list_page.dart';
import 'complaint_category_page.dart';
import 'complaint.dart';
import 'category.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePageContent(),
    ComplaintListPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint App'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/complaint_form');
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Me',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('View Complaints'),
              onTap: () {
                Navigator.pushNamed(context, '/complaint_list');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final List<Category> sectors = [
    Category(title: 'Government', icon: Icons.account_balance),
    Category(title: 'Private', icon: Icons.business),
  ];

  final List<Complaint> recentComplaints = [
    Complaint(
      shopName: 'Government Office',
      complaintText: 'Issue with public service.',
      dateTime: DateTime.now(),
    ),
    Complaint(
      shopName: 'Private Company',
      complaintText: 'Poor customer service.',
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 165,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/homelogo2.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 160),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: sectors.length,
                  itemBuilder: (context, index) {
                    return OpenContainer(
                      closedElevation: 0,
                      transitionDuration: Duration(milliseconds: 500),
                      openBuilder: (context, _) => ComplaintCategoryPage(category: sectors[index]),
                      closedBuilder: (context, openContainer) => GestureDetector(
                        onTap: openContainer,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  sectors[index].icon,
                                  size: 50,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  sectors[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Recent Complaints',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recentComplaints.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          recentComplaints[index].shopName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(recentComplaints[index].complaintText),
                        trailing: Text(
                          '${recentComplaints[index].dateTime.month}/${recentComplaints[index].dateTime.day}/${recentComplaints[index].dateTime.year}',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'About Me Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
