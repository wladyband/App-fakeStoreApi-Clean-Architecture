


import 'package:freezed_annotation/freezed_annotation.dart';
part 'Rating.freezed.dart';
part 'Rating.g.dart';

@Freezed(toJson: true)
class Rating with _$Rating {
  const factory Rating({
    required double rate,
    required int count,
  }) = _Rating;

  const Rating._();

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJsonMap() => {
    'rate': rate,
    'count': count,
  };
}