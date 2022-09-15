import 'package:json_annotation/json_annotation.dart';


part 'incoming_data_model.g.dart';

@JsonSerializable()
class IncomingData {
  bool error;
  String message;
  @JsonKey(name: 'data')
  List<Task>? data;

  IncomingData(
      {required this.error,
        required this.message,
        required this.data,
        });

  factory IncomingData.fromJson(Map<String, dynamic> json) =>
      _$IncomingDataFromJson(json);

  Map<String, dynamic> toJson() => _$IncomingDataToJson(this);
}

@JsonSerializable()
class Task {
  final String id;
  final List<String> field;
  final Coordinates start;
  final Coordinates end;


  Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,

  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable()
class Coordinates {
  final int x;
  final int y;

  Coordinates({
    required this.x,
    required this.y,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
