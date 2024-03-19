import 'package:flutter/material.dart';

class DutyTime extends StatefulWidget {
  const DutyTime({super.key, required this.initialDutyTime, this.onChanged});

  final String initialDutyTime;
  final Function(String?)? onChanged; // Callback function type

  @override
  State<DutyTime> createState() => _DutyTimeState();
}

class _DutyTimeState extends State<DutyTime> {
  String? _selectedDutyTime = '';

  @override
  void initState() {
    super.initState();
    _selectedDutyTime = widget.initialDutyTime ?? ""; // Set initial selected time
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Duty Time"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 86, 86, 100),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back1.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
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
                        onPressed: () {
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
