import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_hackathon_2023/pages/running_dashboard.dart';

class RunDesignPage extends StatefulWidget {
  const RunDesignPage({Key? key}) : super(key: key);

  @override
  State<RunDesignPage> createState() => _RunDesignState();
}

class _RunDesignState extends State<RunDesignPage> {
  final user = FirebaseAuth.instance.currentUser!;
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Run Planner',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 3, 3),
        colorScheme: const ColorScheme.dark(
          secondary: Colors.blue,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _goalTime = 0;
  double _distance = 0.0;
  String _effort = 'Easy Run';
  final List<String> _effortValues = ['Easy Run', 'Break A Sweat', 'Race Pace'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // added this line
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // center the content vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // center the content horizontally
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                const Text(
                  'Start Your Run 🏃‍♂️💨',
                  textAlign: TextAlign.center, // center the text
                  style: TextStyle(
                    color: Color.fromRGBO(172, 237, 81, 1.0),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                pickerCardInt('What is your goal time?', _goalTime, 61,
                    (int newValue) {
                  setState(() {
                    _goalTime = newValue;
                  });
                }),
                pickerCardDouble(
                    'How far would you like to run?', _distance, 30,
                    (double newValue) {
                  setState(() {
                    _distance = newValue;
                  });
                }),
                pickerCardString('At what pace?', _effort, _effortValues,
                    (String newValue) {
                  setState(() {
                    _effort = newValue;
                  });
                }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        // Wrap the FloatingActionButton with Padding
        padding: const EdgeInsets.only(top: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            // action
           Navigator.push(context, MaterialPageRoute(builder: ((context) => RunningDashboard(hour: 1, minute: 1, second: 1, miles: 1, pace: "Hello"))));
          },
          label: const Text('GO'),
          backgroundColor: Colors.green,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Card pickerCardInt(String title, int currentValue, int itemCount,
      ValueChanged<int> onChanged) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color.fromRGBO(172, 237, 81, 1.0),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  height: 96.0,
                  width: constraints.maxWidth * 0.8,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: onChanged,
                    children: List<Widget>.generate(itemCount, (index) {
                      return Text(index.toString());
                    }),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text(
              currentValue.toString() +
                  (currentValue == 1 ? " Minute" : " Minutes"),
              style: const TextStyle(
                color: Color.fromRGBO(172, 237, 81, 1.0),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card pickerCardDouble(String title, double currentValue, int itemCount,
      ValueChanged<double> onChanged) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color.fromRGBO(172, 237, 81, 1.0),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  height: 100.0,
                  width: constraints.maxWidth * 0.8,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      onChanged(index / 10);
                    },
                    children: List<Widget>.generate(itemCount, (index) {
                      return Text((index / 10).toStringAsFixed(1));
                    }),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text(
              currentValue.toStringAsFixed(1) +
                  (currentValue == 1 ? " Mile" : " Miles"),
              style: const TextStyle(
                color: Color.fromRGBO(172, 237, 81, 1.0),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card pickerCardString(String title, String currentValue, List<String> values,
      ValueChanged<String> onChanged) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color.fromRGBO(172, 237, 81, 1.0),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  height: 100.0,
                  width: constraints.maxWidth * 0.8,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      onChanged(values[index]);
                    },
                    children: values.map((String value) {
                      return Text(value);
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Signed in as ${user.email!}'),
//             MaterialButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//               },
//               color: Colors.deepPurple[200],
//               child: Text('sign out'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
