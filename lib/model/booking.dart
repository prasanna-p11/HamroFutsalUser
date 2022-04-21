class AllBookings {
  bool? success;
  List<Booking>? booking;
  String? message;

  AllBookings({this.success, this.booking, this.message});

  AllBookings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      booking = <Booking>[];
      json['data'].forEach((v) {
        booking!.add(Booking.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (booking != null) {
      data['data'] = booking!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Booking {
  String? bookingId;
  String? id;
  String? futsalId;
  String? rangeId;
  String? userId;
  String? paidAmt;
  String? date;
  String? status;
  String? futsalName;
  String? futsalAddress;
  String? futsalContact;
  String? futsalSide;
  String? userName;
  String? userAddress;
  String? userContact;
  String? startTime;
  String? endTime;

  Booking(
      {this.bookingId,
      this.id,
      this.futsalId,
      this.rangeId,
      this.userId,
      this.paidAmt,
      this.date,
      this.status,
      this.futsalName,
      this.futsalAddress,
      this.futsalContact,
      this.futsalSide,
      this.userName,
      this.userAddress,
      this.userContact,
      this.startTime,
      this.endTime});

  Booking.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    id = json['id'];
    futsalId = json['futsal_id'];
    rangeId = json['range_id'];
    userId = json['user_id'];
    paidAmt = json['paid_amt'];
    date = json['date'];
    status = json['status'];
    futsalName = json['futsal_name'];
    futsalAddress = json['futsal_address'];
    futsalContact = json['futsal_contact'];
    futsalSide = json['futsal_side'];
    userName = json['user_name'];
    userAddress = json['user_address'];
    userContact = json['user_contact'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['id'] = id;
    data['futsal_id'] = futsalId;
    data['range_id'] = rangeId;
    data['user_id'] = userId;
    data['paid_amt'] = paidAmt;
    data['date'] = date;
    data['status'] = status;
    data['futsal_name'] = futsalName;
    data['futsal_address'] = futsalAddress;
    data['futsal_contact'] = futsalContact;
    data['futsal_side'] = futsalSide;
    data['user_name'] = userName;
    data['user_address'] = userAddress;
    data['user_contact'] = userContact;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
