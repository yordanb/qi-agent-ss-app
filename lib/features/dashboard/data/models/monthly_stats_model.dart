import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_stats_model.freezed.dart';
part 'monthly_stats_model.g.dart';

@freezed
class MonthlyStatsModel with _$MonthlyStatsModel {
  const factory MonthlyStatsModel({
    required String nrp,
    required String nama,
    required String dept,
    required int year,
    required int month,
    @JsonKey(name: 'month_name') String? monthName,
    @JsonKey(name: 'total_ss') int? totalSs,
    required int closed,
    @JsonKey(name: 'wait_approval') int? waitApproval,
    int? other,
  }) = _MonthlyStatsModel;

  factory MonthlyStatsModel.fromJson(Map<String, dynamic> json) =>
      _$MonthlyStatsModelFromJson(json);
}
