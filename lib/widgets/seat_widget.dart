import 'package:cruv/providers/seat_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatWidget extends StatelessWidget {
  final int start;
  const SeatWidget({required this.start, super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: deviceHeight * 0.2,
      width: deviceWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SixSeater(
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
            start: start,
          ),
          TwoSeater(
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
            start: start + 6,
          )
        ],
      ),
    );
  }
}

class TwoSeater extends StatelessWidget {
  const TwoSeater({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.start,
  });

  final double deviceHeight;
  final double deviceWidth;
  final int start;
  // final int end;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * 0.3,
      width: deviceWidth * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleSeat(
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
            seatNumber: start,
            seatName: 'SIDE LOWER',
            borderLeft: 1,
            borderRight: 1,
            borderTop: 1,
          ),
          SingleSeat(
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
            seatNumber: start + 1,
            seatName: 'SIDE UPPER',
            borderBottom: 1,
            borderLeft: 1,
            borderRight: 1,
          )
        ],
      ),
    );
  }
}

class SingleSeat extends StatefulWidget {
  const SingleSeat({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.seatNumber,
    required this.seatName,
    this.borderLeft = 0,
    this.borderRight = 0,
    this.borderTop = 0,
    this.borderBottom = 0,
  });

  final double deviceHeight;
  final double deviceWidth;
  final double borderLeft;
  final double borderRight;
  final double borderTop;
  final double borderBottom;
  final int seatNumber;
  final String seatName;

  @override
  State<SingleSeat> createState() => _SingleSeatState();
}

class _SingleSeatState extends State<SingleSeat> {
  late Color cardColor;
  late bool hasFocus;

  BorderSide getBorderSide(double border) {
    if (border == 0) {
      return BorderSide.none;
    } else {
      return BorderSide(width: border * 10, color: Colors.blue.shade100);
    }
  }

  @override
  Widget build(BuildContext context) {
    final seatData = Provider.of<SeatDataProvider>(context);
    final List<int> selectedSeats = seatData.selectedSeats;
    final hasFocus = selectedSeats.contains(widget.seatNumber);
    return Container(
      width: widget.deviceWidth * 0.2,
      decoration: BoxDecoration(
        border: Border(
          left: getBorderSide(widget.borderLeft),
          right: getBorderSide(widget.borderRight),
          top: getBorderSide(widget.borderTop),
          bottom: getBorderSide(widget.borderBottom),
        ),
      ),
      height: widget.deviceHeight * 0.08,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: (hasFocus)
            ? Colors.blue.shade500
            : Colors.blue.shade100,
        child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              if (hasFocus) {
                seatData.removeSeat(widget.seatNumber);
                cardColor = Colors.blue.shade100;
              } else {
                seatData.addSeat(widget.seatNumber);
                cardColor = Colors.blue.shade500;
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.seatNumber.toString(),
                  style: TextStyle(fontSize: widget.deviceHeight * 0.03),
                ),
                Text(
                  widget.seatName,
                  style: TextStyle(fontSize: widget.deviceHeight * 0.01),
                ),
              ],
            )),
      ),
    );
  }
}

class SixSeater extends StatelessWidget {
  const SixSeater({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.start,
  });

  final double deviceHeight;
  final double deviceWidth;
  final int start;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * 0.2,
      width: deviceWidth * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              SingleSeat(
                deviceHeight: deviceHeight,
                deviceWidth: deviceWidth,
                seatName: 'LOWER',
                seatNumber: start,
                borderLeft: 1,
                borderTop: 1,
              ),
              SingleSeat(
                deviceWidth: deviceWidth,
                deviceHeight: deviceHeight,
                seatNumber: start + 1,
                seatName: 'MIDDLE',
                borderTop: 1,
              ),
              SingleSeat(
                deviceWidth: deviceWidth,
                seatName: 'UPPER',
                seatNumber: start + 2,
                deviceHeight: deviceHeight,
                borderTop: 1,
                borderRight: 1,
              )
            ],
          ),
          Row(
            children: [
              SingleSeat(
                deviceHeight: deviceHeight,
                deviceWidth: deviceWidth,
                seatName: 'LOWER',
                seatNumber: start + 3,
                borderLeft: 1,
                borderBottom: 1,
              ),
              SingleSeat(
                deviceHeight: deviceHeight,
                deviceWidth: deviceWidth,
                seatName: 'MIDDLE',
                seatNumber: start + 4,
                borderBottom: 1,
              ),
              SingleSeat(
                deviceHeight: deviceHeight,
                deviceWidth: deviceWidth,
                seatName: 'UPPER',
                seatNumber: start + 5,
                borderRight: 1,
                borderBottom: 1,
              )
            ],
          )
        ],
      ),
    );
  }
}
