import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_stats_model.freezed.dart';
part 'dashboard_stats_model.g.dart';

@freezed
class DashBoardStatsModel with _$DashBoardStatsModel {
  const factory DashBoardStatsModel({
    required String nrp,
    required String nama,
    required String dept,
    @JsonKey(name: 'total_ss') required int totalSs,
    required int closed,
    required int open,
    required int other,
    @JsonKey(name: 'last_update') String? lastUpdate,
  }) = _DashBoardStatsModel;

  factory DashBoardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashBoardStatsModelFromJson(json);
}
