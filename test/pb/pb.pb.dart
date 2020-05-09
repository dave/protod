///
//  Generated code. Do not modify.
//  source: pb.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Company extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Company', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(11, 'name')
    ..hasRequiredFields = false
  ;

  Company._() : super();
  factory Company() => create();
  factory Company.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Company.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Company clone() => Company()..mergeFromMessage(this);
  Company copyWith(void Function(Company) updates) => super.copyWith((message) => updates(message as Company));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Company create() => Company._();
  Company createEmptyInstance() => create();
  static $pb.PbList<Company> createRepeated() => $pb.PbList<Company>();
  @$core.pragma('dart2js:noInline')
  static Company getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Company>(create);
  static Company _defaultInstance;

  @$pb.TagNumber(11)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(11)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(11)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(11)
  void clearName() => clearField(11);
}

class Case extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Case', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(12, 'name')
    ..hasRequiredFields = false
  ;

  Case._() : super();
  factory Case() => create();
  factory Case.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Case.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Case clone() => Case()..mergeFromMessage(this);
  Case copyWith(void Function(Case) updates) => super.copyWith((message) => updates(message as Case));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Case create() => Case._();
  Case createEmptyInstance() => create();
  static $pb.PbList<Case> createRepeated() => $pb.PbList<Case>();
  @$core.pragma('dart2js:noInline')
  static Case getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Case>(create);
  static Case _defaultInstance;

  @$pb.TagNumber(12)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(12)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(12)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(12)
  void clearName() => clearField(12);
}

class Person extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Person', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(13, 'name')
    ..a<$core.int>(14, 'age', $pb.PbFieldType.O3)
    ..pc<Case>(15, 'cases', $pb.PbFieldType.PM, subBuilder: Case.create)
    ..aOM<Company>(16, 'company', subBuilder: Company.create)
    ..hasRequiredFields = false
  ;

  Person._() : super();
  factory Person() => create();
  factory Person.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Person.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Person clone() => Person()..mergeFromMessage(this);
  Person copyWith(void Function(Person) updates) => super.copyWith((message) => updates(message as Person));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Person create() => Person._();
  Person createEmptyInstance() => create();
  static $pb.PbList<Person> createRepeated() => $pb.PbList<Person>();
  @$core.pragma('dart2js:noInline')
  static Person getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Person>(create);
  static Person _defaultInstance;

  @$pb.TagNumber(13)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(13)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(13)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(13)
  void clearName() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get age => $_getIZ(1);
  @$pb.TagNumber(14)
  set age($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(14)
  $core.bool hasAge() => $_has(1);
  @$pb.TagNumber(14)
  void clearAge() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<Case> get cases => $_getList(2);

  @$pb.TagNumber(16)
  Company get company => $_getN(3);
  @$pb.TagNumber(16)
  set company(Company v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasCompany() => $_has(3);
  @$pb.TagNumber(16)
  void clearCompany() => clearField(16);
  @$pb.TagNumber(16)
  Company ensureCompany() => $_ensure(3);
}

