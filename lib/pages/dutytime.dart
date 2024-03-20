import 'package:flutter/material.dart';
import 'package:flutter_geolocation_test2/pages/geolocationpage.dart'; // Import GeolocationApp
import 'package:flutter_geolocation_test2/pages/userpage.dart';

class DutyTime extends StatefulWidget {
  const DutyTime({Key? key, this.initialDutyTime, this.onChanged}) : super(key: key);

  final String? initialDutyTime;
  final Function(String?)? onChanged; // Callback function type

  @override
  State<DutyTime> createState() => _DutyTimeState();
}

class _DutyTimeState extends State<DutyTime> {
  late String? _selectedDutyTime;
  final GeolocationApp geolocationApp = GeolocationApp();
  String _currentLocation="";

  @override
  void initState() {
    super.initState();
    _selectedDutyTime = widget.initialDutyTime;
  }

  Future<void> _getCurrentLocation() async {
    await geolocationApp.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Duty Time"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 86, 86, 100),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/back1.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Please select your duty time:', style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 20),
                      DropdownButton<String>(
                        value: _selectedDutyTime,
                        items: const [
                          DropdownMenuItem(value: 't1(6.00 am)', child: Text('t1(6.00 am)')),
                          DropdownMenuItem(value: 't2(8.00 am)', child: Text('t2(8.00 am)')),
                          DropdownMenuItem(value: 't3(9.30 am)', child: Text('t3(9.30 am)')),
                        ],
                        hint: const Text('Select Duty Time'),
                        onChanged: (value) {
                          setState(() {
                            _selectedDutyTime = value;
                            widget.onChanged?.call(value); // Call callback if provided
                          });
                        },
                      ),

                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _getCurrentLocation, // Call _getCurrentLocation directly
                        child: const Text("Get Current Location"),
                      ),

                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserMainPage(selectedDutyTime: _selectedDutyTime)));
                          // Handle form submission (optional, can be removed)
                        },
                        child: const Text("Submit"),
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
