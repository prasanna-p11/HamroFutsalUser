import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamro_futsal/controllers/futsal_controller.dart';
import 'package:hamro_futsal/model/booking.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FutsalController>(builder: (controller) {
      return Scaffold(
          body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children:  [
              const TabBar(tabs: [
                Tab(
                  child: Text('Booked', style: TextStyle(color: Colors.black),),
                ),
                Tab(
                  child: Text('Cancelled', style: TextStyle(color: Colors.black),),
                ),
                Tab(
                  child: Text('Completed', style: TextStyle(color: Colors.black),),
                ),
              ]),
              Expanded(
                child: TabBarView(children: [
                  BookingTab(bookings: controller.bookings.where((element) => element.status == 'booked').toList()),
                  BookingTab(bookings: controller.bookings.where((element) => element.status == 'cancelled').toList()),
                  BookingTab(bookings: controller.bookings.where((element) => element.status == 'completed').toList())
                ],),
              )
            ],
            
          ),
        ),
      ));
    });
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({
    Key? key,
    required this.booking,
  }) : super(key: key);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking.futsalName!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 21,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
                softWrap: false,
              ),
              Text(
                '${booking.futsalSide}A-side',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Color(0xff525252),
                  fontWeight: FontWeight.w700,
                ),
                softWrap: false,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            booking.status!.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Color(0xff525252),
              fontWeight: FontWeight.w700,
            ),
            softWrap: false,
          ),
          Text(
            'Rs. ${booking.paidAmt}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Color(0xff525252),
            ),
            softWrap: false,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${booking.startTime} -${booking.endTime}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
              color: Color(0xff000000),
              fontWeight: FontWeight.w600,
            ),
            softWrap: false,
          ),
        ],
      ),
    );
  }
}


class BookingTab extends StatelessWidget {
  const BookingTab({ Key? key, required this.bookings }) : super(key: key);

  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: bookings
                      .map(
                        (booking) => Slidable(
                          child: BookingCard(
                            booking: booking,
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (a) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Cancel Booking'),
                                          content: const Text(
                                              'Are you sure you want to cancel this booking? You won\'t be refunded'),
                                          actions: [
                                            GetBuilder<FutsalController>(
                                              builder: (controller) {
                                                return ElevatedButton(
                                                  child: const Text('Yes'),
                                                  onPressed: () {
                                                    controller.changeBookingStatus(
                                                        booking.bookingId,
                                                        booking.userId,
                                                        'cancelled',
                                                        context);
                                                  },
                                                );
                                              }
                                            ),
                                            ElevatedButton(
                                              child: const Text('No',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                backgroundColor: const Color(0xFFff0000),
                                foregroundColor: Colors.white,
                                icon: FontAwesomeIcons.trashAlt,
                                label: 'Cancel',
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList()),
            ),
          ),
    );
  }
}