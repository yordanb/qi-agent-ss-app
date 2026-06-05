// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snapshot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnapshotModel _$SnapshotModelFromJson(Map<String, dynamic> json) {
  return _SnapshotModel.fromJson(json);
}

/// @nodoc
mixin _$SnapshotModel {
  int? get id => throw _privateConstructorUsedError;
  String get nrp => throw _privateConstructorUsedError;
  String? get nama => throw _privateConstructorUsedError;
  String? get dept => throw _privateConstructorUsedError;
  String? get divisi => throw _privateConstructorUsedError;
  String? get distrik => throw _privateConstructorUsedError;
  String? get posisi => throw _privateConstructorUsedError;
  @JsonKey(name: 'snapshot_date')
  String? get snapshotDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'dokumen_diakses')
  String? get dokumenDiakses => throw _privateConstructorUsedError;
  @JsonKey(name: 'dokumen_mtd')
  String? get dokumenMtd => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_metrics')
  Map<String, dynamic>? get monthlyMetrics =>
      throw _privateConstructorUsedError;

  /// Serializes this SnapshotModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnapshotModelCopyWith<SnapshotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnapshotModelCopyWith<$Res> {
  factory $SnapshotModelCopyWith(
          SnapshotModel value, $Res Function(SnapshotModel) then) =
      _$SnapshotModelCopyWithImpl<$Res, SnapshotModel>;
  @useResult
  $Res call(
      {int? id,
      String nrp,
      String? nama,
      String? dept,
      String? divisi,
      String? distrik,
      String? posisi,
      @JsonKey(name: 'snapshot_date') String? snapshotDate,
      @JsonKey(name: 'dokumen_diakses') String? dokumenDiakses,
      @JsonKey(name: 'dokumen_mtd') String? dokumenMtd,
      @JsonKey(name: 'monthly_metrics') Map<String, dynamic>? monthlyMetrics});
}

/// @nodoc
class _$SnapshotModelCopyWithImpl<$Res, $Val extends SnapshotModel>
    implements $SnapshotModelCopyWith<$Res> {
  _$SnapshotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nrp = null,
    Object? nama = freezed,
    Object? dept = freezed,
    Object? divisi = freezed,
    Object? distrik = freezed,
    Object? posisi = freezed,
    Object? snapshotDate = freezed,
    Object? dokumenDiakses = freezed,
    Object? dokumenMtd = freezed,
    Object? monthlyMetrics = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nrp: null == nrp
          ? _value.nrp
          : nrp // ignore: cast_nullable_to_non_nullable
              as String,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      dept: freezed == dept
          ? _value.dept
          : dept // ignore: cast_nullable_to_non_nullable
              as String?,
      divisi: freezed == divisi
          ? _value.divisi
          : divisi // ignore: cast_nullable_to_non_nullable
              as String?,
      distrik: freezed == distrik
          ? _value.distrik
          : distrik // ignore: cast_nullable_to_non_nullable
              as String?,
      posisi: freezed == posisi
          ? _value.posisi
          : posisi // ignore: cast_nullable_to_non_nullable
              as String?,
      snapshotDate: freezed == snapshotDate
          ? _value.snapshotDate
          : snapshotDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dokumenDiakses: freezed == dokumenDiakses
          ? _value.dokumenDiakses
          : dokumenDiakses // ignore: cast_nullable_to_non_nullable
              as String?,
      dokumenMtd: freezed == dokumenMtd
          ? _value.dokumenMtd
          : dokumenMtd // ignore: cast_nullable_to_non_nullable
              as String?,
      monthlyMetrics: freezed == monthlyMetrics
          ? _value.monthlyMetrics
          : monthlyMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnapshotModelImplCopyWith<$Res>
    implements $SnapshotModelCopyWith<$Res> {
  factory _$$SnapshotModelImplCopyWith(
          _$SnapshotModelImpl value, $Res Function(_$SnapshotModelImpl) then) =
      __$$SnapshotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String nrp,
      String? nama,
      String? dept,
      String? divisi,
      String? distrik,
      String? posisi,
      @JsonKey(name: 'snapshot_date') String? snapshotDate,
      @JsonKey(name: 'dokumen_diakses') String? dokumenDiakses,
      @JsonKey(name: 'dokumen_mtd') String? dokumenMtd,
      @JsonKey(name: 'monthly_metrics') Map<String, dynamic>? monthlyMetrics});
}

/// @nodoc
class __$$SnapshotModelImplCopyWithImpl<$Res>
    extends _$SnapshotModelCopyWithImpl<$Res, _$SnapshotModelImpl>
    implements _$$SnapshotModelImplCopyWith<$Res> {
  __$$SnapshotModelImplCopyWithImpl(
      _$SnapshotModelImpl _value, $Res Function(_$SnapshotModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nrp = null,
    Object? nama = freezed,
    Object? dept = freezed,
    Object? divisi = freezed,
    Object? distrik = freezed,
    Object? posisi = freezed,
    Object? snapshotDate = freezed,
    Object? dokumenDiakses = freezed,
    Object? dokumenMtd = freezed,
    Object? monthlyMetrics = freezed,
  }) {
    return _then(_$SnapshotModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nrp: null == nrp
          ? _value.nrp
          : nrp // ignore: cast_nullable_to_non_nullable
              as String,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      dept: freezed == dept
          ? _value.dept
          : dept // ignore: cast_nullable_to_non_nullable
              as String?,
      divisi: freezed == divisi
          ? _value.divisi
          : divisi // ignore: cast_nullable_to_non_nullable
              as String?,
      distrik: freezed == distrik
          ? _value.distrik
          : distrik // ignore: cast_nullable_to_non_nullable
              as String?,
      posisi: freezed == posisi
          ? _value.posisi
          : posisi // ignore: cast_nullable_to_non_nullable
              as String?,
      snapshotDate: freezed == snapshotDate
          ? _value.snapshotDate
          : snapshotDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dokumenDiakses: freezed == dokumenDiakses
          ? _value.dokumenDiakses
          : dokumenDiakses // ignore: cast_nullable_to_non_nullable
              as String?,
      dokumenMtd: freezed == dokumenMtd
          ? _value.dokumenMtd
          : dokumenMtd // ignore: cast_nullable_to_non_nullable
              as String?,
      monthlyMetrics: freezed == monthlyMetrics
          ? _value._monthlyMetrics
          : monthlyMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnapshotModelImpl implements _SnapshotModel {
  const _$SnapshotModelImpl(
      {this.id,
      required this.nrp,
      this.nama,
      this.dept,
      this.divisi,
      this.distrik,
      this.posisi,
      @JsonKey(name: 'snapshot_date') this.snapshotDate,
      @JsonKey(name: 'dokumen_diakses') this.dokumenDiakses,
      @JsonKey(name: 'dokumen_mtd') this.dokumenMtd,
      @JsonKey(name: 'monthly_metrics')
      final Map<String, dynamic>? monthlyMetrics})
      : _monthlyMetrics = monthlyMetrics;

  factory _$SnapshotModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnapshotModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String nrp;
  @override
  final String? nama;
  @override
  final String? dept;
  @override
  final String? divisi;
  @override
  final String? distrik;
  @override
  final String? posisi;
  @override
  @JsonKey(name: 'snapshot_date')
  final String? snapshotDate;
  @override
  @JsonKey(name: 'dokumen_diakses')
  final String? dokumenDiakses;
  @override
  @JsonKey(name: 'dokumen_mtd')
  final String? dokumenMtd;
  final Map<String, dynamic>? _monthlyMetrics;
  @override
  @JsonKey(name: 'monthly_metrics')
  Map<String, dynamic>? get monthlyMetrics {
    final value = _monthlyMetrics;
    if (value == null) return null;
    if (_monthlyMetrics is EqualUnmodifiableMapView) return _monthlyMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SnapshotModel(id: $id, nrp: $nrp, nama: $nama, dept: $dept, divisi: $divisi, distrik: $distrik, posisi: $posisi, snapshotDate: $snapshotDate, dokumenDiakses: $dokumenDiakses, dokumenMtd: $dokumenMtd, monthlyMetrics: $monthlyMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnapshotModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nrp, nrp) || other.nrp == nrp) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.dept, dept) || other.dept == dept) &&
            (identical(other.divisi, divisi) || other.divisi == divisi) &&
            (identical(other.distrik, distrik) || other.distrik == distrik) &&
            (identical(other.posisi, posisi) || other.posisi == posisi) &&
            (identical(other.snapshotDate, snapshotDate) ||
                other.snapshotDate == snapshotDate) &&
            (identical(other.dokumenDiakses, dokumenDiakses) ||
                other.dokumenDiakses == dokumenDiakses) &&
            (identical(other.dokumenMtd, dokumenMtd) ||
                other.dokumenMtd == dokumenMtd) &&
            const DeepCollectionEquality()
                .equals(other._monthlyMetrics, _monthlyMetrics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nrp,
      nama,
      dept,
      divisi,
      distrik,
      posisi,
      snapshotDate,
      dokumenDiakses,
      dokumenMtd,
      const DeepCollectionEquality().hash(_monthlyMetrics));

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnapshotModelImplCopyWith<_$SnapshotModelImpl> get copyWith =>
      __$$SnapshotModelImplCopyWithImpl<_$SnapshotModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnapshotModelImplToJson(
      this,
    );
  }
}

abstract class _SnapshotModel implements SnapshotModel {
  const factory _SnapshotModel(
      {final int? id,
      required final String nrp,
      final String? nama,
      final String? dept,
      final String? divisi,
      final String? distrik,
      final String? posisi,
      @JsonKey(name: 'snapshot_date') final String? snapshotDate,
      @JsonKey(name: 'dokumen_diakses') final String? dokumenDiakses,
      @JsonKey(name: 'dokumen_mtd') final String? dokumenMtd,
      @JsonKey(name: 'monthly_metrics')
      final Map<String, dynamic>? monthlyMetrics}) = _$SnapshotModelImpl;

  factory _SnapshotModel.fromJson(Map<String, dynamic> json) =
      _$SnapshotModelImpl.fromJson;

  @override
  int? get id;
  @override
  String get nrp;
  @override
  String? get nama;
  @override
  String? get dept;
  @override
  String? get divisi;
  @override
  String? get distrik;
  @override
  String? get posisi;
  @override
  @JsonKey(name: 'snapshot_date')
  String? get snapshotDate;
  @override
  @JsonKey(name: 'dokumen_diakses')
  String? get dokumenDiakses;
  @override
  @JsonKey(name: 'dokumen_mtd')
  String? get dokumenMtd;
  @override
  @JsonKey(name: 'monthly_metrics')
  Map<String, dynamic>? get monthlyMetrics;

  /// Create a copy of SnapshotModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnapshotModelImplCopyWith<_$SnapshotModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
