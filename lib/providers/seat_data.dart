import 'package:flutter/material.dart';

class SeatDataProvider with ChangeNotifier {
  final List<int> _selectedSeats = [];
  List<int> get selectedSeats => _selectedSeats;

  void addSeat(int seatNumber) {
    if (!_selectedSeats.contains(seatNumber)) {
      _selectedSeats.add(seatNumber);
      notifyListeners();
    }
  }

  void removeSeat(int seatNumber) {
    if (_selectedSeats.contains(seatNumber)) {
      _selectedSeats.remove(seatNumber);
      notifyListeners();
    }
  }
}
