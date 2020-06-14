///
//  Generated code. Do not modify.
//  source: pb.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'pb.pbenum.dart';

export 'pb.pbenum.dart';

class Person_Embed extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Person.Embed', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..hasRequiredFields = false
  ;

  Person_Embed._() : super();
  factory Person_Embed() => create();
  factory Person_Embed.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Person_Embed.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Person_Embed clone() => Person_Embed()..mergeFromMessage(this);
  Person_Embed copyWith(void Function(Person_Embed) updates) => super.copyWith((message) => updates(message as Person_Embed));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Person_Embed create() => Person_Embed._();
  Person_Embed createEmptyInstance() => create();
  static $pb.PbList<Person_Embed> createRepeated() => $pb.PbList<Person_Embed>();
  @$core.pragma('dart2js:noInline')
  static Person_Embed getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Person_Embed>(create);
  static Person_Embed _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class Person extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Person', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..a<$core.int>(2, 'age', $pb.PbFieldType.OU3)
    ..m<$core.String, Case>(4, 'cases', entryClassName: 'Person.CasesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Case.create, packageName: const $pb.PackageName('tests'))
    ..aOM<Company>(5, 'company', subBuilder: Company.create)
    ..pPS(6, 'alias')
    ..e<Person_Type>(7, 'type', $pb.PbFieldType.OE, defaultOrMaker: Person_Type.Alpha, valueOf: Person_Type.valueOf, enumValues: Person_Type.values)
    ..pc<Person_Type>(8, 'typeList', $pb.PbFieldType.PE, protoName: 'typeList', valueOf: Person_Type.valueOf, enumValues: Person_Type.values)
    ..m<$core.String, Person_Type>(9, 'typeMap', protoName: 'typeMap', entryClassName: 'Person.TypeMapEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OE, valueOf: Person_Type.valueOf, enumValues: Person_Type.values, packageName: const $pb.PackageName('tests'))
    ..aOM<Person_Embed>(10, 'embedded', subBuilder: Person_Embed.create)
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

  @$pb.TagNumber(7)
  Person_Type get type => $_getN(5);
  @$pb.TagNumber(7)
  set type(Person_Type v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(7)
  void clearType() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<Person_Type> get typeList => $_getList(6);

  @$pb.TagNumber(9)
  $core.Map<$core.String, Person_Type> get typeMap => $_getMap(7);

  @$pb.TagNumber(10)
  Person_Embed get embedded => $_getN(8);
  @$pb.TagNumber(10)
  set embedded(Person_Embed v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasEmbedded() => $_has(8);
  @$pb.TagNumber(10)
  void clearEmbedded() => clearField(10);
  @$pb.TagNumber(10)
  Person_Embed ensureEmbedded() => $_ensure(8);
}

class Company extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Company', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(11, 'name')
    ..a<$core.double>(12, 'revenue', $pb.PbFieldType.OF)
    ..m<$fixnum.Int64, $core.String>(13, 'flags', entryClassName: 'Company.FlagsEntry', keyFieldType: $pb.PbFieldType.O6, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('tests'))
    ..aOM<Person>(14, 'ceo', subBuilder: Person.create)
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

  @$pb.TagNumber(14)
  Person get ceo => $_getN(3);
  @$pb.TagNumber(14)
  set ceo(Person v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCeo() => $_has(3);
  @$pb.TagNumber(14)
  void clearCeo() => clearField(14);
  @$pb.TagNumber(14)
  Person ensureCeo() => $_ensure(3);
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

class Embedded extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Embedded', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(1, 'embeddedLevel0', protoName: 'embeddedLevel0')
    ..hasRequiredFields = false
  ;

  Embedded._() : super();
  factory Embedded() => create();
  factory Embedded.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Embedded.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Embedded clone() => Embedded()..mergeFromMessage(this);
  Embedded copyWith(void Function(Embedded) updates) => super.copyWith((message) => updates(message as Embedded));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Embedded create() => Embedded._();
  Embedded createEmptyInstance() => create();
  static $pb.PbList<Embedded> createRepeated() => $pb.PbList<Embedded>();
  @$core.pragma('dart2js:noInline')
  static Embedded getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Embedded>(create);
  static Embedded _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get embeddedLevel0 => $_getSZ(0);
  @$pb.TagNumber(1)
  set embeddedLevel0($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmbeddedLevel0() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmbeddedLevel0() => clearField(1);
}

class ScopeLevel1_Embedded extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScopeLevel1.Embedded', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(1, 'embeddedLevel1', protoName: 'embeddedLevel1')
    ..hasRequiredFields = false
  ;

  ScopeLevel1_Embedded._() : super();
  factory ScopeLevel1_Embedded() => create();
  factory ScopeLevel1_Embedded.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScopeLevel1_Embedded.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ScopeLevel1_Embedded clone() => ScopeLevel1_Embedded()..mergeFromMessage(this);
  ScopeLevel1_Embedded copyWith(void Function(ScopeLevel1_Embedded) updates) => super.copyWith((message) => updates(message as ScopeLevel1_Embedded));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1_Embedded create() => ScopeLevel1_Embedded._();
  ScopeLevel1_Embedded createEmptyInstance() => create();
  static $pb.PbList<ScopeLevel1_Embedded> createRepeated() => $pb.PbList<ScopeLevel1_Embedded>();
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1_Embedded getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScopeLevel1_Embedded>(create);
  static ScopeLevel1_Embedded _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get embeddedLevel1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set embeddedLevel1($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmbeddedLevel1() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmbeddedLevel1() => clearField(1);
}

class ScopeLevel1_ScopeLevel2_Embedded extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScopeLevel1.ScopeLevel2.Embedded', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOS(1, 'embeddedLevel2', protoName: 'embeddedLevel2')
    ..hasRequiredFields = false
  ;

  ScopeLevel1_ScopeLevel2_Embedded._() : super();
  factory ScopeLevel1_ScopeLevel2_Embedded() => create();
  factory ScopeLevel1_ScopeLevel2_Embedded.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScopeLevel1_ScopeLevel2_Embedded.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ScopeLevel1_ScopeLevel2_Embedded clone() => ScopeLevel1_ScopeLevel2_Embedded()..mergeFromMessage(this);
  ScopeLevel1_ScopeLevel2_Embedded copyWith(void Function(ScopeLevel1_ScopeLevel2_Embedded) updates) => super.copyWith((message) => updates(message as ScopeLevel1_ScopeLevel2_Embedded));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1_ScopeLevel2_Embedded create() => ScopeLevel1_ScopeLevel2_Embedded._();
  ScopeLevel1_ScopeLevel2_Embedded createEmptyInstance() => create();
  static $pb.PbList<ScopeLevel1_ScopeLevel2_Embedded> createRepeated() => $pb.PbList<ScopeLevel1_ScopeLevel2_Embedded>();
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1_ScopeLevel2_Embedded getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScopeLevel1_ScopeLevel2_Embedded>(create);
  static ScopeLevel1_ScopeLevel2_Embedded _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get embeddedLevel2 => $_getSZ(0);
  @$pb.TagNumber(1)
  set embeddedLevel2($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmbeddedLevel2() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmbeddedLevel2() => clearField(1);
}

class ScopeLevel1_ScopeLevel2_ScopeLevel3 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScopeLevel1.ScopeLevel2.ScopeLevel3', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOM<ScopeLevel1_ScopeLevel2_Embedded>(1, 't', subBuilder: ScopeLevel1_ScopeLevel2_Embedded.create)
    ..hasRequiredFields = false
  ;

  ScopeLevel1_ScopeLevel2_ScopeLevel3._() : super();
  factory ScopeLevel1_ScopeLevel2_ScopeLevel3() => create();
  factory ScopeLevel1_ScopeLevel2_ScopeLevel3.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScopeLevel1_ScopeLevel2_ScopeLevel3.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ScopeLevel1_ScopeLevel2_ScopeLevel3 clone() => ScopeLevel1_ScopeLevel2_ScopeLevel3()..mergeFromMessage(this);
  ScopeLevel1_ScopeLevel2_ScopeLevel3 copyWith(void Function(ScopeLevel1_ScopeLevel2_ScopeLevel3) updates) => super.copyWith((message) => updates(message as ScopeLevel1_ScopeLevel2_ScopeLevel3));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1_ScopeLevel2_ScopeLevel3 create() => ScopeLevel1_ScopeLevel2_ScopeLevel3._();
  ScopeLevel1_ScopeLevel2_ScopeLevel3 createEmptyInstance() => create();
  static $pb.PbList<ScopeLevel1_ScopeLevel2_ScopeLevel3> createRepeated() => $pb.PbList<ScopeLevel1_ScopeLevel2_ScopeLevel3>();
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1_ScopeLevel2_ScopeLevel3 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScopeLevel1_ScopeLevel2_ScopeLevel3>(create);
  static ScopeLevel1_ScopeLevel2_ScopeLevel3 _defaultInstance;

  @$pb.TagNumber(1)
  ScopeLevel1_ScopeLevel2_Embedded get t => $_getN(0);
  @$pb.TagNumber(1)
  set t(ScopeLevel1_ScopeLevel2_Embedded v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasT() => $_has(0);
  @$pb.TagNumber(1)
  void clearT() => clearField(1);
  @$pb.TagNumber(1)
  ScopeLevel1_ScopeLevel2_Embedded ensureT() => $_ensure(0);
}

class ScopeLevel1_ScopeLevel2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScopeLevel1.ScopeLevel2', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOM<ScopeLevel1_ScopeLevel2_Embedded>(1, 't', subBuilder: ScopeLevel1_ScopeLevel2_Embedded.create)
    ..hasRequiredFields = false
  ;

  ScopeLevel1_ScopeLevel2._() : super();
  factory ScopeLevel1_ScopeLevel2() => create();
  factory ScopeLevel1_ScopeLevel2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScopeLevel1_ScopeLevel2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ScopeLevel1_ScopeLevel2 clone() => ScopeLevel1_ScopeLevel2()..mergeFromMessage(this);
  ScopeLevel1_ScopeLevel2 copyWith(void Function(ScopeLevel1_ScopeLevel2) updates) => super.copyWith((message) => updates(message as ScopeLevel1_ScopeLevel2));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1_ScopeLevel2 create() => ScopeLevel1_ScopeLevel2._();
  ScopeLevel1_ScopeLevel2 createEmptyInstance() => create();
  static $pb.PbList<ScopeLevel1_ScopeLevel2> createRepeated() => $pb.PbList<ScopeLevel1_ScopeLevel2>();
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1_ScopeLevel2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScopeLevel1_ScopeLevel2>(create);
  static ScopeLevel1_ScopeLevel2 _defaultInstance;

  @$pb.TagNumber(1)
  ScopeLevel1_ScopeLevel2_Embedded get t => $_getN(0);
  @$pb.TagNumber(1)
  set t(ScopeLevel1_ScopeLevel2_Embedded v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasT() => $_has(0);
  @$pb.TagNumber(1)
  void clearT() => clearField(1);
  @$pb.TagNumber(1)
  ScopeLevel1_ScopeLevel2_Embedded ensureT() => $_ensure(0);
}

class ScopeLevel1 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScopeLevel1', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOM<ScopeLevel1_Embedded>(1, 't', subBuilder: ScopeLevel1_Embedded.create)
    ..hasRequiredFields = false
  ;

  ScopeLevel1._() : super();
  factory ScopeLevel1() => create();
  factory ScopeLevel1.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScopeLevel1.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ScopeLevel1 clone() => ScopeLevel1()..mergeFromMessage(this);
  ScopeLevel1 copyWith(void Function(ScopeLevel1) updates) => super.copyWith((message) => updates(message as ScopeLevel1));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1 create() => ScopeLevel1._();
  ScopeLevel1 createEmptyInstance() => create();
  static $pb.PbList<ScopeLevel1> createRepeated() => $pb.PbList<ScopeLevel1>();
  @$core.pragma('dart2js:noInline')
  static ScopeLevel1 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScopeLevel1>(create);
  static ScopeLevel1 _defaultInstance;

  @$pb.TagNumber(1)
  ScopeLevel1_Embedded get t => $_getN(0);
  @$pb.TagNumber(1)
  set t(ScopeLevel1_Embedded v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasT() => $_has(0);
  @$pb.TagNumber(1)
  void clearT() => clearField(1);
  @$pb.TagNumber(1)
  ScopeLevel1_Embedded ensureT() => $_ensure(0);
}

