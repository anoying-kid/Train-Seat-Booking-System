import 'package:cruv/providers/seat_data.dart';
import 'package:cruv/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SeatBookingScreen extends StatefulWidget {
  const SeatBookingScreen({super.key});

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  final double _trainRating = 4.8;

  final List<int> _seatNumbers = [1, 9, 17, 25, 33, 41, 49, 57];

  final ScrollController _scrollController = ScrollController();

  final _seatNumberController = TextEditingController();

  bool _showFab = true;

  void scrollAnimated(double position) {
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Color ratingColor(double trainRating) {
    if (trainRating > 0 && trainRating < 1.5) {
      return Colors.red;
    } else if (trainRating >= 1.5 && trainRating < 3.5) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  void submit(SeatDataProvider seatData) {
    final int seatNumber = int.parse(_seatNumberController.text);

    if (seatNumber > 64) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Only 64 Seats are available')));
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      if (seatNumber > 32) {
        scrollAnimated(_scrollController.position.maxScrollExtent);
        seatData.addSeat(seatNumber);
      } else {
        seatData.addSeat(seatNumber);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    final deviceWidth = MediaQuery.of(context).size.width;
    final seatData = Provider.of<SeatDataProvider>(context);
    return Scaffold(
      floatingActionButton: AnimatedSlide(
        offset: (MediaQuery.of(context).viewInsets.bottom == 0 && _showFab)
            ? Offset.zero
            : const Offset(0, 2),
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/selected-seats');
          },
          child: const Icon(Icons.check),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is UserScrollNotification) {
            if (notification.direction == ScrollDirection.forward) {
              _showFab = true;
            } else if (notification.direction == ScrollDirection.reverse) {
              _showFab = false;
            }
            setState(() {});
          }
          return true;
        },
        child: SizedBox(
            height: deviceHeight,
            width: deviceWidth,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.1,
                      width: deviceWidth * 0.6,
                      child: TextField(
                        onSubmitted: (value) => submit(seatData),
                        onTap: () => _seatNumberController.selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset:
                                    _seatNumberController.value.text.length),
                        controller: _seatNumberController,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(counterText: ''),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      height: deviceHeight * 0.1,
                      width: deviceWidth * 0.2,
                      child: IconButton(
                          onPressed: () {
                            submit(seatData);
                          },
                          icon: const Icon(Icons.search)),
                    )
                  ],
                ),
                Column(
                  children: _seatNumbers
                      .map((e) => SeatWidget(
                            start: e,
                          ))
                      .toList(),
                )
              ]),
            )),
      ),
    );
  }
}
