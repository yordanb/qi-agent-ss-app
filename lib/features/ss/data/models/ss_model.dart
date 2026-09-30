import 'package:freezed_annotation/freezed_annotation.dart';

part 'ss_model.freezed.dart';
part 'ss_model.g.dart';

@freezed
class SsModel with _$SsModel {
  const factory SsModel({
    @JsonKey(name: 'no_ss') required String noSs, // ignore: invalid_annotation_target
    required String judul,
    required String nrp,
    String? nama,
    String? dept,
    String? divisi,
    String? distrik,
    @JsonKey(name: 'tanggal_laporan') String? tanggalLaporan, // ignore: invalid_annotation_target
    @JsonKey(name: 'grade_ss') String? gradeSs, // ignore: invalid_annotation_target
    @JsonKey(name: 'kualitas_ss') String? kualitasSs, // ignore: invalid_annotation_target
    @JsonKey(name: 'kategori_ss') String? kategoriSs, // ignore: invalid_annotation_target
    @JsonKey(name: 'reward_ss') double? rewardSs, // ignore: invalid_annotation_target
    @JsonKey(name: 'status_karyawan') String? statusKaryawan, // ignore: invalid_annotation_target
    @JsonKey(name: 'manfaat_financial') double? manfaatFinancial, // ignore: invalid_annotation_target
    @JsonKey(name: 'tanggal_menilai') String? tanggalMenilai, // ignore: invalid_annotation_target
    @JsonKey(name: 'dinilai_oleh') String? dinilaiOleh, // ignore: invalid_annotation_target
    @JsonKey(name: 'current_status') String? currentStatus, // ignore: invalid_annotation_target
    String? source,
    @JsonKey(name: 'created_at') String? createdAt, // ignore: invalid_annotation_target
    @JsonKey(name: 'updated_at') String? updatedAt, // ignore: invalid_annotation_target
  }) = _SsModel;

  factory SsModel.fromJson(Map<String, dynamic> json) => _$SsModelFromJson(json);
}
