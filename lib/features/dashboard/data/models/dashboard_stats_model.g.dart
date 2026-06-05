// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashBoardStatsModelImpl _$$DashBoardStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashBoardStatsModelImpl(
      nrp: json['nrp'] as String,
      nama: json['nama'] as String,
      dept: json['dept'] as String,
      totalSs: (json['total_ss'] as num).toInt(),
      closed: (json['closed'] as num).toInt(),
      outstanding: (json['outstanding'] as num).toInt(),
      waitApproval: (json['wait_approval'] as num).toInt(),
      other: (json['other'] as num).toInt(),
      lastUpdate: json['last_update'] as String?,
    );

Map<String, dynamic> _$$DashBoardStatsModelImplToJson(
        _$DashBoardStatsModelImpl instance) =>
    <String, dynamic>{
      'nrp': instance.nrp,
      'nama': instance.nama,
      'dept': instance.dept,
      'total_ss': instance.totalSs,
      'closed': instance.closed,
      'outstanding': instance.outstanding,
      'wait_approval': instance.waitApproval,
      'other': instance.other,
      'last_update': instance.lastUpdate,
    };
