// import 'package:flutter/material.dart';

// class FootballScoreCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Team Score Card'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Team Names
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Home Team',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Away Team',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             // Score and Match Info
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '2 - 1', // Home team score
//                   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Full Time',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 Text(
//                   '1 - 2', // Away team score
//                   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             // View Match Info Button
//             ElevatedButton(
//               onPressed: () {
//                 // Handle button press to view match info
//               },
//               child: Text('View Match Info'),
//             ),
//             SizedBox(height: 24),
//             // Some Text Design
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 'Some Text Design',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
