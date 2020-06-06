///
//  Generated code. Do not modify.
//  source: pb.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Person extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Person', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..a<$core.int>(2, 'age', $pb.PbFieldType.OU3)
    ..m<$core.String, Case>(4, 'cases', entryClassName: 'Person.CasesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Case.create, packageName: const $pb.PackageName('tests'))
    ..aOM<Company>(5, 'company', subBuilder: Company.create)
    ..pPS(6, 'alias')
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

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get age => $_getIZ(1);
  @$pb.TagNumber(2)
  set age($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAge() => $_has(1);
  @$pb.TagNumber(2)
  void clearAge() => clearField(2);

  @$pb.TagNumber(4)
  $core.Map<$core.String, Case> get cases => $_getMap(2);

  @$pb.TagNumber(5)
  Company get company => $_getN(3);
  @$pb.TagNumber(5)
  set company(Company v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCompany() => $_has(3);
  @$pb.TagNumber(5)
  void clearCompany() => clearField(5);
  @$pb.TagNumber(5)
  Company ensureCompany() => $_ensure(3);

  @$pb.TagNumber(6)
  $core.List<$core.String> get alias => $_getList(4);
}

class Company extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Company', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(11, 'name')
    ..a<$core.double>(12, 'revenue', $pb.PbFieldType.OF)
    ..m<$fixnum.Int64, $core.String>(13, 'flags', entryClassName: 'Company.FlagsEntry', keyFieldType: $pb.PbFieldType.O6, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('tests'))
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

  @$pb.TagNumber(12)
  $core.double get revenue => $_getN(1);
  @$pb.TagNumber(12)
  set revenue($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(12)
  $core.bool hasRevenue() => $_has(1);
  @$pb.TagNumber(12)
  void clearRevenue() => clearField(12);

  @$pb.TagNumber(13)
  $core.Map<$fixnum.Int64, $core.String> get flags => $_getMap(2);
}

class Case extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Case', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(21, 'name')
    ..pc<Item>(22, 'items', $pb.PbFieldType.PM, subBuilder: Item.create)
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

  @$pb.TagNumber(21)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(21)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(21)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(21)
  void clearName() => clearField(21);

  @$pb.TagNumber(22)
  $core.List<Item> get items => $_getList(1);
}

class Item extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Item', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(31, 'title')
    ..aOB(34, 'done')
    ..pPS(35, 'flags')
    ..hasRequiredFields = false
  ;

  Item._() : super();
  factory Item() => create();
  factory Item.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Item.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Item clone() => Item()..mergeFromMessage(this);
  Item copyWith(void Function(Item) updates) => super.copyWith((message) => updates(message as Item));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Item create() => Item._();
  Item createEmptyInstance() => create();
  static $pb.PbList<Item> createRepeated() => $pb.PbList<Item>();
  @$core.pragma('dart2js:noInline')
  static Item getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Item>(create);
  static Item _defaultInstance;

  @$pb.TagNumber(31)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(31)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(31)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(31)
  void clearTitle() => clearField(31);

  @$pb.TagNumber(34)
  $core.bool get done => $_getBF(1);
  @$pb.TagNumber(34)
  set done($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(34)
  $core.bool hasDone() => $_has(1);
  @$pb.TagNumber(34)
  void clearDone() => clearField(34);

  @$pb.TagNumber(35)
  $core.List<$core.String> get flags => $_getList(2);
}

class Holder extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Holder', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..m<$core.String, $core.int>(1, 'numbers', entryClassName: 'Holder.NumbersEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O3, packageName: const $pb.PackageName('tests'))
    ..hasRequiredFields = false
  ;

  Holder._() : super();
  factory Holder() => create();
  factory Holder.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Holder.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Holder clone() => Holder()..mergeFromMessage(this);
  Holder copyWith(void Function(Holder) updates) => super.copyWith((message) => updates(message as Holder));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Holder create() => Holder._();
  Holder createEmptyInstance() => create();
  static $pb.PbList<Holder> createRepeated() => $pb.PbList<Holder>();
  @$core.pragma('dart2js:noInline')
  static Holder getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Holder>(create);
  static Holder _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.int> get numbers => $_getMap(0);
}

