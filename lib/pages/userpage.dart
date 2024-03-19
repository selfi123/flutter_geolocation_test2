import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geolocation_test2/pages/dutytime.dart'; // Import DutyTime

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String _staffId = "";
  List<Duty> _duties = [];
  String? _selectedDutyTime;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _getPostedDuties();
  }

  Future<void> _getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _staffId = user.uid;
      });
    }
  }

  Future<void> _getPostedDuties() async {
    // Replace 'duties' with your actual collection name for duties
    final dutiesCollection = await _firestore.collection('duties').get();
    setState(() {
      _duties = dutiesCollection.docs.map((doc) => Duty.fromSnapshot(doc)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Home - $_staffId'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logged In Staff ID: $_staffId',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Selected Duty Time: ${_selectedDutyTime ?? 'Not Selected'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // Duty Time widget
            DutyTime(
              initialDutyTime: _selectedDutyTime  ?? "",
              onChanged: (newDutyTime) {
                setState(() {
                  _selectedDutyTime = newDutyTime;
                });
              },
            ),

            const Divider(thickness: 1.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Posted Duties:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _duties.length,
                    itemBuilder: (context, index) {
                      final duty = _duties[index];
                      return Text(
                        '- ${duty.title} (Due: ${duty.dueDate.toString()})',
                        style: const TextStyle(fontSize: 14),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
