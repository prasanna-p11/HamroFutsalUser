// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/controllers/futsal_controller.dart';
import 'package:hamro_futsal/model/futsal.dart';
import 'package:hamro_futsal/model/time_range.dart';
import 'package:hamro_futsal/screens/payment.dart';
import 'package:hamro_futsal/utils/baseurl.dart';
import 'package:intl/intl.dart';

class FutsalDesc extends StatelessWidget {
  FutsalDesc({Key? key}) : super(key: key);

  final Futsal futsal = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final FutsalController futsalController = Get.find();
    futsalController.getTimeRange(futsal.id);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                image: NetworkImage(baseurl + futsal.image!),
              ),
              Positioned(
                top: 30,
                left: 10,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        futsal.name!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 31,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: false,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${futsal.side}A-side',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xff525252),
                        fontWeight: FontWeight.w700,
                      ),
                      softWrap: false,
                    )
                  ],
                ),
                Text(
                  'Rs. ${futsal.price}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Color(0xff525252),
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  futsal.address!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Color(0xff9c9c9c),
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: false,
                ),
                Text(
                  futsal.contact!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Color(0xff9c9c9c),
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  futsal.description!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Color(0xff242424),
                  ),
                  softWrap: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Booking Times:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<FutsalController>(builder: (controller) {
                  return Column(
                    children: controller.timeRange
                        .map((timeRange) =>
                            TimeCard(timeRange: timeRange, futsal: futsal))
                        .toList(),
                  );
                })
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class TimeCard extends StatelessWidget {
  const TimeCard({
    Key? key,
    required this.timeRange,
    required this.futsal,
  }) : super(key: key);
  final TimeRange timeRange;
  final Futsal futsal;

  @override
  Widget build(BuildContext context) {
    var isVisible = false;
    DateTime startDate = DateFormat("hh:mm a").parse(timeRange.startTime!);

    // format date
    var time1 = DateFormat("HH:mm").format(startDate);
    var time2 = DateFormat("HH:mm").format(DateTime.now());
    var t1 = int.parse(time1.substring(0, 2));
    var t2 = int.parse(time2.substring(0, 2));
    if (t1 > t2) {
      isVisible = true;
    }
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '${timeRange.startTime} -${timeRange.endTime}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
              color: Color(0xff000000),
              fontWeight: FontWeight.w600,
            ),
            softWrap: false,
          ),
          GetBuilder<FutsalController>(builder: (controller) {
            return InkWell(
              onTap: () {
                if (timeRange.status == "0") {
                  showDialog(
                      context: (context),
                      builder: (context) => AlertDialog(
                            title: const Text('Book Futsal'),
                            content: Text(
                                'You will have to pay ${int.parse(futsal.price!) / 2} as a booking amount.'),
                            actions: [
                              FlatButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: const Text('Book'),
                                onPressed: () async {
                                  final token = await showDialog(
                                      context: (context),
                                      builder: (context) =>
                                           KhaltiPayment(
                                            onPaid:()async{
                                              await controller.bookFutsal(
                                      futsal.id,
                                      timeRange.id,
                                      int.parse(futsal.price!) / 2,
                                      context);
                                            }
                                          ));
                                  

                                  
                                  
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ));
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: timeRange.status == "0"
                      ? const Color(0xff166f28)
                      : const Color(0xffFF0000),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Text(
                  timeRange.status == "0" ? "Book" : "Booked",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: false,
                ),
              ),
            );
          })
        ]),
      ),
    );
  }
}
