import 'package:freezed_annotation/freezed_annotation.dart';

part 'ss_page_model.freezed.dart';
part 'ss_page_model.g.dart';

@freezed
class SsPageModel with _$SsPageModel {
  const factory SsPageModel({
    required int total,
    required int page,
    @JsonKey(name: 'page_size') required int pageSize,
    required List<dynamic> data,
  }) = _SsPageModel;

  factory SsPageModel.fromJson(Map<String, dynamic> json) => _$SsPageModelFromJson(json);
}
