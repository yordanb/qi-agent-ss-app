import 'package:freezed_annotation/freezed_annotation.dart';

part 'snapshot_model.freezed.dart';
part 'snapshot_model.g.dart';

@freezed
class SnapshotModel with _$SnapshotModel {
  const factory SnapshotModel({
    int? id,
    required String nrp,
    String? nama,
    String? dept,
    String? divisi,
    String? distrik,
    String? posisi,
    @JsonKey(name: 'snapshot_date') String? snapshotDate, // ignore: invalid_annotation_target
    @JsonKey(name: 'dokumen_diakses') String? dokumenDiakses, // ignore: invalid_annotation_target
    @JsonKey(name: 'dokumen_mtd') String? dokumenMtd, // ignore: invalid_annotation_target
    @JsonKey(name: 'monthly_metrics') Map<String, dynamic>? monthlyMetrics, // ignore: invalid_annotation_target
  }) = _SnapshotModel;

  factory SnapshotModel.fromJson(Map<String, dynamic> json) => _$SnapshotModelFromJson(json);
}
