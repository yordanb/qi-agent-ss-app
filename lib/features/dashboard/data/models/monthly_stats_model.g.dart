// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonthlyStatsModelImpl _$$MonthlyStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MonthlyStatsModelImpl(
      nrp: json['nrp'] as String,
      nama: json['nama'] as String,
      dept: json['dept'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      monthName: json['month_name'] as String?,
      totalSs: (json['total_ss'] as num?)?.toInt(),
      closed: (json['closed'] as num).toInt(),
      open: (json['open'] as num).toInt(),
      other: (json['other'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MonthlyStatsModelImplToJson(
        _$MonthlyStatsModelImpl instance) =>
    <String, dynamic>{
      'nrp': instance.nrp,
      'nama': instance.nama,
      'dept': instance.dept,
      'year': instance.year,
      'month': instance.month,
      'month_name': instance.monthName,
      'total_ss': instance.totalSs,
      'closed': instance.closed,
      'open': instance.open,
      'other': instance.other,
    };
