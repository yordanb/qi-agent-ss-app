// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MonthlyStatsModel _$MonthlyStatsModelFromJson(Map<String, dynamic> json) {
  return _MonthlyStatsModel.fromJson(json);
}

/// @nodoc
mixin _$MonthlyStatsModel {
  String get nrp => throw _privateConstructorUsedError;
  String get nama => throw _privateConstructorUsedError;
  String get dept => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'month_name')
  String? get monthName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_ss')
  int? get totalSs => throw _privateConstructorUsedError;
  int get closed => throw _privateConstructorUsedError;
  @JsonKey(name: 'wait_approval')
  int? get waitApproval => throw _privateConstructorUsedError;
  int? get other => throw _privateConstructorUsedError;

  /// Serializes this MonthlyStatsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyStatsModelCopyWith<MonthlyStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyStatsModelCopyWith<$Res> {
  factory $MonthlyStatsModelCopyWith(
          MonthlyStatsModel value, $Res Function(MonthlyStatsModel) then) =
      _$MonthlyStatsModelCopyWithImpl<$Res, MonthlyStatsModel>;
  @useResult
  $Res call(
      {String nrp,
      String nama,
      String dept,
      int year,
      int month,
      @JsonKey(name: 'month_name') String? monthName,
      @JsonKey(name: 'total_ss') int? totalSs,
      int closed,
      @JsonKey(name: 'wait_approval') int? waitApproval,
      int? other});
}

/// @nodoc
class _$MonthlyStatsModelCopyWithImpl<$Res, $Val extends MonthlyStatsModel>
    implements $MonthlyStatsModelCopyWith<$Res> {
  _$MonthlyStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nrp = null,
    Object? nama = null,
    Object? dept = null,
    Object? year = null,
    Object? month = null,
    Object? monthName = freezed,
    Object? totalSs = freezed,
    Object? closed = null,
    Object? waitApproval = freezed,
    Object? other = freezed,
  }) {
    return _then(_value.copyWith(
      nrp: null == nrp
          ? _value.nrp
          : nrp // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      dept: null == dept
          ? _value.dept
          : dept // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      monthName: freezed == monthName
          ? _value.monthName
          : monthName // ignore: cast_nullable_to_non_nullable
              as String?,
      totalSs: freezed == totalSs
          ? _value.totalSs
          : totalSs // ignore: cast_nullable_to_non_nullable
              as int?,
      closed: null == closed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as int,
      waitApproval: freezed == waitApproval
          ? _value.waitApproval
          : waitApproval // ignore: cast_nullable_to_non_nullable
              as int?,
      other: freezed == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyStatsModelImplCopyWith<$Res>
    implements $MonthlyStatsModelCopyWith<$Res> {
  factory _$$MonthlyStatsModelImplCopyWith(_$MonthlyStatsModelImpl value,
          $Res Function(_$MonthlyStatsModelImpl) then) =
      __$$MonthlyStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nrp,
      String nama,
      String dept,
      int year,
      int month,
      @JsonKey(name: 'month_name') String? monthName,
      @JsonKey(name: 'total_ss') int? totalSs,
      int closed,
      @JsonKey(name: 'wait_approval') int? waitApproval,
      int? other});
}

/// @nodoc
class __$$MonthlyStatsModelImplCopyWithImpl<$Res>
    extends _$MonthlyStatsModelCopyWithImpl<$Res, _$MonthlyStatsModelImpl>
    implements _$$MonthlyStatsModelImplCopyWith<$Res> {
  __$$MonthlyStatsModelImplCopyWithImpl(_$MonthlyStatsModelImpl _value,
      $Res Function(_$MonthlyStatsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlyStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nrp = null,
    Object? nama = null,
    Object? dept = null,
    Object? year = null,
    Object? month = null,
    Object? monthName = freezed,
    Object? totalSs = freezed,
    Object? closed = null,
    Object? waitApproval = freezed,
    Object? other = freezed,
  }) {
    return _then(_$MonthlyStatsModelImpl(
      nrp: null == nrp
          ? _value.nrp
          : nrp // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      dept: null == dept
          ? _value.dept
          : dept // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      monthName: freezed == monthName
          ? _value.monthName
          : monthName // ignore: cast_nullable_to_non_nullable
              as String?,
      totalSs: freezed == totalSs
          ? _value.totalSs
          : totalSs // ignore: cast_nullable_to_non_nullable
              as int?,
      closed: null == closed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as int,
      waitApproval: freezed == waitApproval
          ? _value.waitApproval
          : waitApproval // ignore: cast_nullable_to_non_nullable
              as int?,
      other: freezed == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyStatsModelImpl implements _MonthlyStatsModel {
  const _$MonthlyStatsModelImpl(
      {required this.nrp,
      required this.nama,
      required this.dept,
      required this.year,
      required this.month,
      @JsonKey(name: 'month_name') this.monthName,
      @JsonKey(name: 'total_ss') this.totalSs,
      required this.closed,
      @JsonKey(name: 'wait_approval') this.waitApproval,
      this.other});

  factory _$MonthlyStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyStatsModelImplFromJson(json);

  @override
  final String nrp;
  @override
  final String nama;
  @override
  final String dept;
  @override
  final int year;
  @override
  final int month;
  @override
  @JsonKey(name: 'month_name')
  final String? monthName;
  @override
  @JsonKey(name: 'total_ss')
  final int? totalSs;
  @override
  final int closed;
  @override
  @JsonKey(name: 'wait_approval')
  final int? waitApproval;
  @override
  final int? other;

  @override
  String toString() {
    return 'MonthlyStatsModel(nrp: $nrp, nama: $nama, dept: $dept, year: $year, month: $month, monthName: $monthName, totalSs: $totalSs, closed: $closed, waitApproval: $waitApproval, other: $other)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyStatsModelImpl &&
            (identical(other.nrp, nrp) || other.nrp == nrp) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.dept, dept) || other.dept == dept) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthName, monthName) ||
                other.monthName == monthName) &&
            (identical(other.totalSs, totalSs) || other.totalSs == totalSs) &&
            (identical(other.closed, closed) || other.closed == closed) &&
            (identical(other.waitApproval, waitApproval) ||
                other.waitApproval == waitApproval) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nrp, nama, dept, year, month,
      monthName, totalSs, closed, waitApproval, other);

  /// Create a copy of MonthlyStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyStatsModelImplCopyWith<_$MonthlyStatsModelImpl> get copyWith =>
      __$$MonthlyStatsModelImplCopyWithImpl<_$MonthlyStatsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyStatsModelImplToJson(
      this,
    );
  }
}

abstract class _MonthlyStatsModel implements MonthlyStatsModel {
  const factory _MonthlyStatsModel(
      {required final String nrp,
      required final String nama,
      required final String dept,
      required final int year,
      required final int month,
      @JsonKey(name: 'month_name') final String? monthName,
      @JsonKey(name: 'total_ss') final int? totalSs,
      required final int closed,
      @JsonKey(name: 'wait_approval') final int? waitApproval,
      final int? other}) = _$MonthlyStatsModelImpl;

  factory _MonthlyStatsModel.fromJson(Map<String, dynamic> json) =
      _$MonthlyStatsModelImpl.fromJson;

  @override
  String get nrp;
  @override
  String get nama;
  @override
  String get dept;
  @override
  int get year;
  @override
  int get month;
  @override
  @JsonKey(name: 'month_name')
  String? get monthName;
  @override
  @JsonKey(name: 'total_ss')
  int? get totalSs;
  @override
  int get closed;
  @override
  @JsonKey(name: 'wait_approval')
  int? get waitApproval;
  @override
  int? get other;

  /// Create a copy of MonthlyStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyStatsModelImplCopyWith<_$MonthlyStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
