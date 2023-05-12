import 'package:cruv/screens/seat_booking_screen.dart';
import 'package:cruv/providers/seat_data.dart';
import 'package:cruv/screens/selected_seats_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SeatDataProvider())
      ],
      child: MaterialApp(
        routes: {
          '/selected-seats':(context) => const SelectedSeatsScreen(),
        },
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        )),
        home: const SeatBookingScreen(),
      ),
    );
  }
}
