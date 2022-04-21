class AllTimeRange {
  bool? success;
  List<TimeRange>? timeRange;
  String? message;

  AllTimeRange({this.success, this.timeRange, this.message});

  AllTimeRange.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      timeRange = <TimeRange>[];
      json['data'].forEach((v) {
        timeRange!.add(TimeRange.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (timeRange != null) {
      data['data'] = timeRange!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class TimeRange {
  String? id;
  String? startTime;
  String? endTime;
  String? status;

  TimeRange({this.id, this.startTime, this.endTime, this.status});

  TimeRange.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    return data;
  }
}
