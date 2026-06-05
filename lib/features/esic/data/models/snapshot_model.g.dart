// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snapshot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SnapshotModelImpl _$$SnapshotModelImplFromJson(Map<String, dynamic> json) =>
    _$SnapshotModelImpl(
      id: (json['id'] as num?)?.toInt(),
      nrp: json['nrp'] as String,
      nama: json['nama'] as String?,
      dept: json['dept'] as String?,
      divisi: json['divisi'] as String?,
      distrik: json['distrik'] as String?,
      posisi: json['posisi'] as String?,
      snapshotDate: json['snapshot_date'] as String?,
      dokumenDiakses: json['dokumen_diakses'] as String?,
      dokumenMtd: json['dokumen_mtd'] as String?,
      monthlyMetrics: json['monthly_metrics'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SnapshotModelImplToJson(_$SnapshotModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nrp': instance.nrp,
      'nama': instance.nama,
      'dept': instance.dept,
      'divisi': instance.divisi,
      'distrik': instance.distrik,
      'posisi': instance.posisi,
      'snapshot_date': instance.snapshotDate,
      'dokumen_diakses': instance.dokumenDiakses,
      'dokumen_mtd': instance.dokumenMtd,
      'monthly_metrics': instance.monthlyMetrics,
    };
