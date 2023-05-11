import 'package:cruv/widgets/seat_widget.dart';
import 'package:flutter/material.dart';

class SeatBookingScreen extends StatelessWidget {
  const SeatBookingScreen({super.key});
  final double _trainRating = 4.8;

  // final List<int> seatNumbers = [1,9,17,25, 33, 41, 49, 57]

  Color ratingColor(double trainRating) {
    if (trainRating > 0 && trainRating < 1.5) {
      return Colors.red;
    } else if (trainRating >= 1.5 && trainRating < 3.5) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Seat Finder',
            style: TextStyle(color: Colors.blue),
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: ratingColor(_trainRating)),
              child: Text(_trainRating.toString()))
        ]),
      ),
      body: Container(
          height: deviceHeight,
          width: deviceWidth,
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [
                  Container(
                    // color: Colors.amber,
                    height: deviceHeight * 0.1,
                    width: deviceWidth * 0.8,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    width: deviceWidth * 0.2,
                    child:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  )
                ],
              ),
              Column(children: [
                SeatWidget(
                  start: 1,
                ),
              ])
            ]),
          )),
    );
  }
}
