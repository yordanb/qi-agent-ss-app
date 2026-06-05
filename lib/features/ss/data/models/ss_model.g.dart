// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SsModelImpl _$$SsModelImplFromJson(Map<String, dynamic> json) =>
    _$SsModelImpl(
      noSs: json['no_ss'] as String,
      judul: json['judul'] as String,
      nrp: json['nrp'] as String,
      nama: json['nama'] as String?,
      dept: json['dept'] as String?,
      divisi: json['divisi'] as String?,
      distrik: json['distrik'] as String?,
      tanggalLaporan: json['tanggal_laporan'] as String?,
      gradeSs: json['grade_ss'] as String?,
      kualitasSs: json['kualitas_ss'] as String?,
      kategoriSs: json['kategori_ss'] as String?,
      rewardSs: (json['reward_ss'] as num?)?.toDouble(),
      statusKaryawan: json['status_karyawan'] as String?,
      manfaatFinancial: (json['manfaat_financial'] as num?)?.toDouble(),
      tanggalMenilai: json['tanggal_menilai'] as String?,
      dinilaiOleh: json['dinilai_oleh'] as String?,
      currentStatus: json['current_status'] as String?,
      source: json['source'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$SsModelImplToJson(_$SsModelImpl instance) =>
    <String, dynamic>{
      'no_ss': instance.noSs,
      'judul': instance.judul,
      'nrp': instance.nrp,
      'nama': instance.nama,
      'dept': instance.dept,
      'divisi': instance.divisi,
      'distrik': instance.distrik,
      'tanggal_laporan': instance.tanggalLaporan,
      'grade_ss': instance.gradeSs,
      'kualitas_ss': instance.kualitasSs,
      'kategori_ss': instance.kategoriSs,
      'reward_ss': instance.rewardSs,
      'status_karyawan': instance.statusKaryawan,
      'manfaat_financial': instance.manfaatFinancial,
      'tanggal_menilai': instance.tanggalMenilai,
      'dinilai_oleh': instance.dinilaiOleh,
      'current_status': instance.currentStatus,
      'source': instance.source,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
