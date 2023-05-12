import 'package:cruv/providers/seat_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedSeatsScreen extends StatelessWidget {
  const SelectedSeatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seatData = Provider.of<SeatDataProvider>(context);
    final String selectedSeats = seatData.selectedSeats.join(', ');
    return Scaffold(
      body: Center(child: Text('[$selectedSeats]')),
    );
  }
}
