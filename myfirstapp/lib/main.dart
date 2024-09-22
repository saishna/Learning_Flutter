// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Flutter Container')),
//         body: Center(
//           child: Container(
//             width: 100,
//             height: 100,
//             color: Colors.blue,
//             child:Text('Hello world!') // Correct property name for color
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _incrementCounter,
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Rows and Columns in Flutter"),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 "Column Example:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Column(
//                 // Column arranges widgets vertically
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     color: Colors.blue,
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "Item 1",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     color: Colors.green,
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "Item 2",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     color: Colors.red,
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "Item 3",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30),
//               Text(
//                 "Row Example:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 // Row arranges widgets horizontally
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     color: Colors.orange,
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "Item A",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.purple,
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "Item B",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.teal,
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "Item C",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Scrollable Rows and Columns"),
//         ),
//         body: SingleChildScrollView(
//           // This allows scrolling
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Scrollable Column Example:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Column(
//                 children: [
//                   for (int i = 1; i <= 10; i++) // Generating items dynamically
//                     Container(
//                       color: i.isEven ? Colors.blue : Colors.green,
//                       margin: EdgeInsets.symmetric(vertical: 8),
//                       padding: EdgeInsets.all(16),
//                       child: Text(
//                         "Item $i",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                 ],
//               ),
//               SizedBox(height: 30),
//               Text(
//                 "Scrollable Row Example:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal, // Horizontal scrolling
//                 child: Row(
//                   children: [
//                     for (int i = 1; i <= 5; i++) // Generating items dynamically
//                       Container(
//                         color: i.isEven ? Colors.orange : Colors.purple,
//                         margin: EdgeInsets.symmetric(horizontal: 8),
//                         padding: EdgeInsets.all(16),
//                         child: Text(
//                           "Item $i",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               Text(
//                 "Mixed Scrollable Widgets:",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                   itemCount: 20, // A longer list to demonstrate scrolling
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.symmetric(vertical: 8),
//                       padding: EdgeInsets.all(16),
//                       color: index.isEven ? Colors.red : Colors.teal,
//                       child: Text(
//                         "List Item ${index + 1}",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Scrollable Container')),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(
              20, // Number of containers to display
                  (index) => Container(
                margin: EdgeInsets.all(10), // Spacing between containers
                height: 100,
                color: Colors.primaries[index % Colors.primaries.length], // Different colors for each container
                child: Center(
                  child: Text(
                    'Container $index',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
