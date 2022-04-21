import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/model/booking.dart';
import 'package:hamro_futsal/model/futsal.dart';
import 'package:hamro_futsal/model/time_range.dart';
import 'package:hamro_futsal/model/user.dart';
import 'package:hamro_futsal/utils/baseurl.dart';
import 'package:hamro_futsal/utils/custom_snackbar.dart';
import 'package:hamro_futsal/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;

class FutsalController extends GetxController {
  List<Futsal> futsals = [];
  List<Futsal> filteredFutsals = [];

  List<TimeRange> timeRange = [];

  List<Booking> bookings = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllFutsals();
    getBookedFutsal();
  }

  fetchAllFutsals() async {
    var response = await http.get(Uri.parse(baseurl + 'getAllFutsals.php'));
    var res = json.decode(response.body);
    if (res['success']) {
      futsals = AllFutsals.fromJson(res).futsal!;
      filteredFutsals = AllFutsals.fromJson(res).futsal!;
    } else {
      customSnackbar('Futsal Fetch Failed', res['message'][0], 'error');
    }
    update();
  }

  search(String val) {
    if (val.isNotEmpty) {
      filteredFutsals = futsals
          .where((futsal) =>
              futsal.name!.toLowerCase().contains(val.toLowerCase()) ||
              futsal.price!.toLowerCase().contains(val.toLowerCase()) ||
              futsal.address!.toLowerCase().contains(val.toLowerCase()) ||
              futsal.side!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filteredFutsals = futsals;
    }
    update();
  }

  getTimeRange(id) async {
    var response = await http
        .post(Uri.parse(baseurl + 'timerange.php'), body: {"futsal_id": id});
    var res = json.decode(response.body);
    if (res['success']) {
      timeRange = AllTimeRange.fromJson(res).timeRange!;
    } else {
      customSnackbar('Time Range Fetch Failed', res['message'][0], 'error');
    }
    update();
    getBookedFutsal();
  }

  getBookedFutsal() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http.post(Uri.parse(baseurl + 'getBookings.php'),
        body: {"user_id": user.userId});
    var res = json.decode(response.body);
    if (res['success']) {
      bookings = AllBookings.fromJson(res).booking!;
    } else {
      customSnackbar('Booking Fetch Failed', res['message'][0], 'error');
    }
    update();
  }

  bookFutsal(futsalId, rangeId, paidAmt, context) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response =
        await http.post(Uri.parse(baseurl + 'book_futsal.php'), body: {
      "futsal_id": futsalId,
      "range_id": rangeId,
      "user_id": user.userId,
      "paid_amt": paidAmt.toString()
    });

    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      getBookedFutsal();
      getTimeRange(futsalId);
    } else {
      customSnackbar('Failed', res['message'][0], 'error');
    }
  }



  changeBookingStatus(bookId, userId, status, context) async {
    var response = await http.post(
        Uri.parse(baseurl + 'changeBookingStatus.php'),
        body: {"booking_id": bookId, "user_id": userId, "status": status});

    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      getBookedFutsal();
      Navigator.pop(context);
    } else {
      customSnackbar('Failed', res['message'][0], 'error');
    }
  }
}
