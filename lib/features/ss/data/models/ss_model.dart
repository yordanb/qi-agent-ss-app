import 'package:freezed_annotation/freezed_annotation.dart';

part 'ss_model.freezed.dart';
part 'ss_model.g.dart';

@freezed
class SsModel with _$SsModel {
  const factory SsModel({
    @JsonKey(name: 'no_ss') required String noSs,
    required String judul,
    required String nrp,
    String? nama,
    String? dept,
    String? divisi,
    String? distrik,
    @JsonKey(name: 'tanggal_laporan') String? tanggalLaporan,
    @JsonKey(name: 'grade_ss') String? gradeSs,
    @JsonKey(name: 'kualitas_ss') String? kualitasSs,
    @JsonKey(name: 'kategori_ss') String? kategoriSs,
    @JsonKey(name: 'reward_ss') double? rewardSs,
    @JsonKey(name: 'status_karyawan') String? statusKaryawan,
    @JsonKey(name: 'manfaat_financial') double? manfaatFinancial,
    @JsonKey(name: 'tanggal_menilai') String? tanggalMenilai,
    @JsonKey(name: 'dinilai_oleh') String? dinilaiOleh,
    @JsonKey(name: 'current_status') String? currentStatus,
    String? source,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _SsModel;

  factory SsModel.fromJson(Map<String, dynamic> json) => _$SsModelFromJson(json);
}
