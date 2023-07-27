


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

  static Rating fromJsonMap(Map<String, dynamic> jsonMap) {
    return Rating(
      rate: (jsonMap['rate'] as num).toDouble(), // Converte para double
      count: jsonMap['count'] as int, // Mantém o tipo int
    );
  }

  Map<String, dynamic> toJsonMap() => {
    'rate': rate,
    'count': count,
  };
}