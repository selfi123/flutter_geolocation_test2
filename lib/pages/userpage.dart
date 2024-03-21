import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_geolocation_test2/pages/dutytime.dart';
import 'package:flutter_geolocation_test2/pages/signinpage.dart'; // Import DutyTime

class UserMainPage extends StatefulWidget {
  final String? selectedDutyTime;

  const UserMainPage({Key? key, this.selectedDutyTime}) : super(key: key);

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final _auth = FirebaseAuth.instance;
  String _staffId = "";
  String? _selectedDutyTime;
  //List<Duty> _duties = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _selectedDutyTime = widget.selectedDutyTime;
    //_getPostedDuties();
  }

  Future<void> _getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _staffId = user.email.toString().split('@').first;
      });
    }
  }
  Future<void> signOut() async{
    await _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
  }
  /*Future<void> _getPostedDuties() async {
    final dutiesCollection = await _firestore.collection('duties').get();
    setState(() {
      _duties = dutiesCollection.docs.map((doc) => Duty.fromSnapshot(doc)).toList();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Home - $_staffId'),
      ),
      body: SingleChildScrollView(
        child:
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the Home Page',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 5),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Selected Duty Time: ${_selectedDutyTime ?? 'Not Selected'}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              // Duty Time widget
              DutyTime(
                initialDutyTime: _selectedDutyTime ?? "",
                onChanged: (newDutyTime) {
                  setState(() {
                    _selectedDutyTime = newDutyTime;
                  });
                },
              ),
              Divider(thickness: 1.0),
              Text(
                'Posted Duties:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              // Add your ListView.builder here if needed
            ],
          ),
        ),

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
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
              title: Text('Home'),
              onTap: () {
                // Handle tap on Home menu item
                // For example, navigate to another page
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Handle tap on About menu item
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Handle tap on Logout menu item
                // For example, sign out the user
                signOut();
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),

    );
  }
}

//ListView.builder(
//  shrinkWrap: true,
// itemCount: _duties.length,
// itemBuilder: (context, index) {
// final duty = _duties[index];
// return Text(
// '- ${duty.title} (Due: ${duty.dueDate.toString()})',
// style: const TextStyle(fontSize: 14),
//);
//  },
//),