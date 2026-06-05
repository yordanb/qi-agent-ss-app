// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SsPageModelImpl _$$SsPageModelImplFromJson(Map<String, dynamic> json) =>
    _$SsPageModelImpl(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      data: json['data'] as List<dynamic>,
    );

Map<String, dynamic> _$$SsPageModelImplToJson(_$SsPageModelImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.pageSize,
      'data': instance.data,
    };
