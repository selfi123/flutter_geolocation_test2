import 'package:flutter/material.dart';
import 'package:flutter_geolocation_test2/pages/userpage.dart';

class DutyTime extends StatefulWidget {
  const DutyTime({super.key});

  @override
  State<DutyTime> createState() => _DutyTimeState();
}

class _DutyTimeState extends State<DutyTime> {
  final _formKey = GlobalKey<FormState>();


  // List of duty time options (can be customized)
  final List<String> dutyTimeOptions = ['t1(6.00 am)', 't2(8.00 am)', 't3(9.30 am)'];
  String? _selectedDutyTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Current Duty Time"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 86, 86, 100),
          foregroundColor: Colors.white,
        ),
        body:Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage('assets/back1.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  )
              ),
            ),


            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Please select your duty time:', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 20),

                        // Dropdown for selecting duty time
                        DropdownButton<String>(
                          value: _selectedDutyTime,
                          items: dutyTimeOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: const Text('Select Duty Time'),
                          onChanged: (value) {
                            setState(() {
                              _selectedDutyTime = value;
                            });
                          },
                        ),

                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_selectedDutyTime!=null) {
                              // Handle form submission
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserFunctions()));
                            }
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
        )
    );
  }

}
