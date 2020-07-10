///
//  Generated code. Do not modify.
//  source: tests.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'package:protod/delta/delta.pb.dart' as $0;
import 'package:protod/google/protobuf/any.pb.dart' as $1;

import 'tests.pbenum.dart';

export 'tests.pbenum.dart';

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
    ..e<Person_Type>(7, 'type', $pb.PbFieldType.OE, defaultOrMaker: Person_Type.Null, valueOf: Person_Type.valueOf, enumValues: Person_Type.values)
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
    ..m<$fixnum.Int64, $core.String>(23, 'flags', entryClassName: 'Case.FlagsEntry', keyFieldType: $pb.PbFieldType.O6, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('tests'))
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

  @$pb.TagNumber(23)
  $core.Map<$fixnum.Int64, $core.String> get flags => $_getMap(2);
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

enum Chooser_Choice {
  str, 
  dbl, 
  itm, 
  notSet
}

class Chooser extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Chooser_Choice> _Chooser_ChoiceByTag = {
    1 : Chooser_Choice.str,
    2 : Chooser_Choice.dbl,
    3 : Chooser_Choice.itm,
    0 : Chooser_Choice.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Chooser', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(1, 'str')
    ..a<$core.double>(2, 'dbl', $pb.PbFieldType.OD)
    ..aOM<Item>(3, 'itm', subBuilder: Item.create)
    ..hasRequiredFields = false
  ;

  Chooser._() : super();
  factory Chooser() => create();
  factory Chooser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chooser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Chooser clone() => Chooser()..mergeFromMessage(this);
  Chooser copyWith(void Function(Chooser) updates) => super.copyWith((message) => updates(message as Chooser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chooser create() => Chooser._();
  Chooser createEmptyInstance() => create();
  static $pb.PbList<Chooser> createRepeated() => $pb.PbList<Chooser>();
  @$core.pragma('dart2js:noInline')
  static Chooser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chooser>(create);
  static Chooser _defaultInstance;

  Chooser_Choice whichChoice() => _Chooser_ChoiceByTag[$_whichOneof(0)];
  void clearChoice() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get str => $_getSZ(0);
  @$pb.TagNumber(1)
  set str($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStr() => $_has(0);
  @$pb.TagNumber(1)
  void clearStr() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get dbl => $_getN(1);
  @$pb.TagNumber(2)
  set dbl($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDbl() => $_has(1);
  @$pb.TagNumber(2)
  void clearDbl() => clearField(2);

  @$pb.TagNumber(3)
  Item get itm => $_getN(2);
  @$pb.TagNumber(3)
  set itm(Item v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasItm() => $_has(2);
  @$pb.TagNumber(3)
  void clearItm() => clearField(3);
  @$pb.TagNumber(3)
  Item ensureItm() => $_ensure(2);
}

class ApplyTestCase extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ApplyTestCase', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOB(1, 'solo')
    ..aOS(2, 'name')
    ..aOM<$0.Op>(3, 'op', subBuilder: $0.Op.create)
    ..aOM<$1.Any>(4, 'data', subBuilder: $1.Any.create)
    ..aOM<$1.Any>(5, 'expected', subBuilder: $1.Any.create)
    ..hasRequiredFields = false
  ;

  ApplyTestCase._() : super();
  factory ApplyTestCase() => create();
  factory ApplyTestCase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApplyTestCase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ApplyTestCase clone() => ApplyTestCase()..mergeFromMessage(this);
  ApplyTestCase copyWith(void Function(ApplyTestCase) updates) => super.copyWith((message) => updates(message as ApplyTestCase));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApplyTestCase create() => ApplyTestCase._();
  ApplyTestCase createEmptyInstance() => create();
  static $pb.PbList<ApplyTestCase> createRepeated() => $pb.PbList<ApplyTestCase>();
  @$core.pragma('dart2js:noInline')
  static ApplyTestCase getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApplyTestCase>(create);
  static ApplyTestCase _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get solo => $_getBF(0);
  @$pb.TagNumber(1)
  set solo($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSolo() => $_has(0);
  @$pb.TagNumber(1)
  void clearSolo() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $0.Op get op => $_getN(2);
  @$pb.TagNumber(3)
  set op($0.Op v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOp() => $_has(2);
  @$pb.TagNumber(3)
  void clearOp() => clearField(3);
  @$pb.TagNumber(3)
  $0.Op ensureOp() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Any get data => $_getN(3);
  @$pb.TagNumber(4)
  set data($1.Any v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => clearField(4);
  @$pb.TagNumber(4)
  $1.Any ensureData() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Any get expected => $_getN(4);
  @$pb.TagNumber(5)
  set expected($1.Any v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpected() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpected() => clearField(5);
  @$pb.TagNumber(5)
  $1.Any ensureExpected() => $_ensure(4);
}

class TransformTestCase extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TransformTestCase', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOB(1, 'solo')
    ..aOS(2, 'name')
    ..aOM<$0.Op>(3, 'op1', subBuilder: $0.Op.create)
    ..aOM<$0.Op>(4, 'op2', subBuilder: $0.Op.create)
    ..aOM<$1.Any>(5, 'data', subBuilder: $1.Any.create)
    ..aOM<$1.Any>(6, 'expected', subBuilder: $1.Any.create)
    ..aOM<$1.Any>(7, 'expected1', subBuilder: $1.Any.create)
    ..aOM<$1.Any>(8, 'expected2', subBuilder: $1.Any.create)
    ..hasRequiredFields = false
  ;

  TransformTestCase._() : super();
  factory TransformTestCase() => create();
  factory TransformTestCase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransformTestCase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TransformTestCase clone() => TransformTestCase()..mergeFromMessage(this);
  TransformTestCase copyWith(void Function(TransformTestCase) updates) => super.copyWith((message) => updates(message as TransformTestCase));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransformTestCase create() => TransformTestCase._();
  TransformTestCase createEmptyInstance() => create();
  static $pb.PbList<TransformTestCase> createRepeated() => $pb.PbList<TransformTestCase>();
  @$core.pragma('dart2js:noInline')
  static TransformTestCase getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransformTestCase>(create);
  static TransformTestCase _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get solo => $_getBF(0);
  @$pb.TagNumber(1)
  set solo($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSolo() => $_has(0);
  @$pb.TagNumber(1)
  void clearSolo() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $0.Op get op1 => $_getN(2);
  @$pb.TagNumber(3)
  set op1($0.Op v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOp1() => $_has(2);
  @$pb.TagNumber(3)
  void clearOp1() => clearField(3);
  @$pb.TagNumber(3)
  $0.Op ensureOp1() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Op get op2 => $_getN(3);
  @$pb.TagNumber(4)
  set op2($0.Op v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOp2() => $_has(3);
  @$pb.TagNumber(4)
  void clearOp2() => clearField(4);
  @$pb.TagNumber(4)
  $0.Op ensureOp2() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Any get data => $_getN(4);
  @$pb.TagNumber(5)
  set data($1.Any v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasData() => $_has(4);
  @$pb.TagNumber(5)
  void clearData() => clearField(5);
  @$pb.TagNumber(5)
  $1.Any ensureData() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Any get expected => $_getN(5);
  @$pb.TagNumber(6)
  set expected($1.Any v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasExpected() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpected() => clearField(6);
  @$pb.TagNumber(6)
  $1.Any ensureExpected() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Any get expected1 => $_getN(6);
  @$pb.TagNumber(7)
  set expected1($1.Any v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasExpected1() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpected1() => clearField(7);
  @$pb.TagNumber(7)
  $1.Any ensureExpected1() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Any get expected2 => $_getN(7);
  @$pb.TagNumber(8)
  set expected2($1.Any v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasExpected2() => $_has(7);
  @$pb.TagNumber(8)
  void clearExpected2() => clearField(8);
  @$pb.TagNumber(8)
  $1.Any ensureExpected2() => $_ensure(7);
}

class RandomTestItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RandomTestItem', package: const $pb.PackageName('tests'), createEmptyInstance: create)
    ..aOM<$0.Op>(1, 'op', subBuilder: $0.Op.create)
    ..aOM<Person>(2, 'expected', subBuilder: Person.create)
    ..hasRequiredFields = false
  ;

  RandomTestItem._() : super();
  factory RandomTestItem() => create();
  factory RandomTestItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RandomTestItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RandomTestItem clone() => RandomTestItem()..mergeFromMessage(this);
  RandomTestItem copyWith(void Function(RandomTestItem) updates) => super.copyWith((message) => updates(message as RandomTestItem));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RandomTestItem create() => RandomTestItem._();
  RandomTestItem createEmptyInstance() => create();
  static $pb.PbList<RandomTestItem> createRepeated() => $pb.PbList<RandomTestItem>();
  @$core.pragma('dart2js:noInline')
  static RandomTestItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RandomTestItem>(create);
  static RandomTestItem _defaultInstance;

  @$pb.TagNumber(1)
  $0.Op get op => $_getN(0);
  @$pb.TagNumber(1)
  set op($0.Op v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOp() => $_has(0);
  @$pb.TagNumber(1)
  void clearOp() => clearField(1);
  @$pb.TagNumber(1)
  $0.Op ensureOp() => $_ensure(0);

  @$pb.TagNumber(2)
  Person get expected => $_getN(1);
  @$pb.TagNumber(2)
  set expected(Person v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasExpected() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpected() => clearField(2);
  @$pb.TagNumber(2)
  Person ensureExpected() => $_ensure(1);
}

