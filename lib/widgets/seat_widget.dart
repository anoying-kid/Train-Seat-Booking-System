import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final int start;
  // final int end;
  SeatWidget({required this.start, super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.pink,
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
    // required this.end,
  });

  final double deviceHeight;
  final double deviceWidth;
  final int start;
  // final int end;

  @override
  Widget build(BuildContext context) {
    return Container(
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
  // final FocusNode _cardFocusNode = FocusNode();

  Color cardColor = Colors.blue.shade100;
  bool hasFocus = false;

  BorderSide getBorderSide(double border) {
    if (border == 0) {
      return BorderSide.none;
    } else {
      return BorderSide(width: border);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        color: cardColor,
        child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              if (hasFocus) {
                cardColor = Colors.blue.shade100;
                hasFocus = false;
              } else {
                cardColor = Colors.blue.shade500;
                hasFocus = true;
              }
              setState(() {});
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
    return Container(
      // color: Colors.blue,
      height: deviceHeight * 0.2,
      width: deviceWidth * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // color: Colors.blue,
            child: Row(
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
          ),
          Container(
            // color: Colors.blue,
            child: Row(
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
            ),
          )
        ],
      ),
    );
  }
}
