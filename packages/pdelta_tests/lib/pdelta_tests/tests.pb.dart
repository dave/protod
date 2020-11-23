///
//  Generated code. Do not modify.
//  source: pdelta_tests/tests.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'house.pb.dart' as $0;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/shirt.pb.dart' as $1;
import 'package:pdelta_tests_clothes/pdelta_tests_clothes/pants/pants.pb.dart' as $2;
import 'package:pdelta/pdelta/pdelta.pb.dart' as $3;
import 'package:ptypes/google/protobuf/any.pb.dart' as $4;

import 'tests.pbenum.dart';

export 'tests.pbenum.dart';

enum Person_Embed_Double_Foo {
  bar, 
  baz, 
  notSet
}

class Person_Embed_Double extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Person_Embed_Double_Foo> _Person_Embed_Double_FooByTag = {
    2 : Person_Embed_Double_Foo.bar,
    3 : Person_Embed_Double_Foo.baz,
    0 : Person_Embed_Double_Foo.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Person.Embed.Double', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bar')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'baz')
    ..hasRequiredFields = false
  ;

  Person_Embed_Double._() : super();
  factory Person_Embed_Double() => create();
  factory Person_Embed_Double.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Person_Embed_Double.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Person_Embed_Double clone() => Person_Embed_Double()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Person_Embed_Double copyWith(void Function(Person_Embed_Double) updates) => super.copyWith((message) => updates(message as Person_Embed_Double)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Person_Embed_Double create() => Person_Embed_Double._();
  Person_Embed_Double createEmptyInstance() => create();
  static $pb.PbList<Person_Embed_Double> createRepeated() => $pb.PbList<Person_Embed_Double>();
  @$core.pragma('dart2js:noInline')
  static Person_Embed_Double getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Person_Embed_Double>(create);
  static Person_Embed_Double _defaultInstance;

  Person_Embed_Double_Foo whichFoo() => _Person_Embed_Double_FooByTag[$_whichOneof(0)];
  void clearFoo() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bar => $_getSZ(1);
  @$pb.TagNumber(2)
  set bar($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBar() => $_has(1);
  @$pb.TagNumber(2)
  void clearBar() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get baz => $_getI64(2);
  @$pb.TagNumber(3)
  set baz($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBaz() => $_has(2);
  @$pb.TagNumber(3)
  void clearBaz() => clearField(3);
}

class Person_Embed extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Person.Embed', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  Person_Embed._() : super();
  factory Person_Embed() => create();
  factory Person_Embed.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Person_Embed.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Person_Embed clone() => Person_Embed()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Person_Embed copyWith(void Function(Person_Embed) updates) => super.copyWith((message) => updates(message as Person_Embed)); // ignore: deprecated_member_use
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

enum Person_Choice {
  str, 
  dbl, 
  itm, 
  cas, 
  cho, 
  notSet
}

class Person extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Person_Choice> _Person_ChoiceByTag = {
    11 : Person_Choice.str,
    12 : Person_Choice.dbl,
    13 : Person_Choice.itm,
    14 : Person_Choice.cas,
    15 : Person_Choice.cho,
    0 : Person_Choice.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Person', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..oo(0, [11, 12, 13, 14, 15])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'age', $pb.PbFieldType.OU3)
    ..m<$core.String, Case>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cases', entryClassName: 'Person.CasesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Case.create, packageName: const $pb.PackageName('pdelta_tests'))
    ..aOM<Company>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'company', subBuilder: Company.create)
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alias')
    ..e<Person_Type>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Person_Type.Null, valueOf: Person_Type.valueOf, enumValues: Person_Type.values)
    ..pc<Person_Type>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'typeList', $pb.PbFieldType.PE, protoName: 'typeList', valueOf: Person_Type.valueOf, enumValues: Person_Type.values)
    ..m<$core.String, Person_Type>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'typeMap', protoName: 'typeMap', entryClassName: 'Person.TypeMapEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OE, valueOf: Person_Type.valueOf, enumValues: Person_Type.values, packageName: const $pb.PackageName('pdelta_tests'))
    ..aOM<Person_Embed>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'embedded', subBuilder: Person_Embed.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'str')
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dbl', $pb.PbFieldType.OD)
    ..aOM<Item>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itm', subBuilder: Item.create)
    ..aOM<Case>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cas', subBuilder: Case.create)
    ..aOM<Chooser>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cho', subBuilder: Chooser.create)
    ..aOM<$0.House>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'house', subBuilder: $0.House.create)
    ..aOM<$1.Shirt>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shirt', subBuilder: $1.Shirt.create)
    ..aOM<$2.Pants>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pants', subBuilder: $2.Pants.create)
    ..aOM<Person_Embed_Double>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'double', subBuilder: Person_Embed_Double.create)
    ..hasRequiredFields = false
  ;

  Person._() : super();
  factory Person() => create();
  factory Person.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Person.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Person clone() => Person()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Person copyWith(void Function(Person) updates) => super.copyWith((message) => updates(message as Person)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Person create() => Person._();
  Person createEmptyInstance() => create();
  static $pb.PbList<Person> createRepeated() => $pb.PbList<Person>();
  @$core.pragma('dart2js:noInline')
  static Person getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Person>(create);
  static Person _defaultInstance;

  Person_Choice whichChoice() => _Person_ChoiceByTag[$_whichOneof(0)];
  void clearChoice() => clearField($_whichOneof(0));

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

  @$pb.TagNumber(11)
  $core.String get str => $_getSZ(9);
  @$pb.TagNumber(11)
  set str($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasStr() => $_has(9);
  @$pb.TagNumber(11)
  void clearStr() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get dbl => $_getN(10);
  @$pb.TagNumber(12)
  set dbl($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasDbl() => $_has(10);
  @$pb.TagNumber(12)
  void clearDbl() => clearField(12);

  @$pb.TagNumber(13)
  Item get itm => $_getN(11);
  @$pb.TagNumber(13)
  set itm(Item v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasItm() => $_has(11);
  @$pb.TagNumber(13)
  void clearItm() => clearField(13);
  @$pb.TagNumber(13)
  Item ensureItm() => $_ensure(11);

  @$pb.TagNumber(14)
  Case get cas => $_getN(12);
  @$pb.TagNumber(14)
  set cas(Case v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCas() => $_has(12);
  @$pb.TagNumber(14)
  void clearCas() => clearField(14);
  @$pb.TagNumber(14)
  Case ensureCas() => $_ensure(12);

  @$pb.TagNumber(15)
  Chooser get cho => $_getN(13);
  @$pb.TagNumber(15)
  set cho(Chooser v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCho() => $_has(13);
  @$pb.TagNumber(15)
  void clearCho() => clearField(15);
  @$pb.TagNumber(15)
  Chooser ensureCho() => $_ensure(13);

  @$pb.TagNumber(16)
  $0.House get house => $_getN(14);
  @$pb.TagNumber(16)
  set house($0.House v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasHouse() => $_has(14);
  @$pb.TagNumber(16)
  void clearHouse() => clearField(16);
  @$pb.TagNumber(16)
  $0.House ensureHouse() => $_ensure(14);

  @$pb.TagNumber(17)
  $1.Shirt get shirt => $_getN(15);
  @$pb.TagNumber(17)
  set shirt($1.Shirt v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasShirt() => $_has(15);
  @$pb.TagNumber(17)
  void clearShirt() => clearField(17);
  @$pb.TagNumber(17)
  $1.Shirt ensureShirt() => $_ensure(15);

  @$pb.TagNumber(18)
  $2.Pants get pants => $_getN(16);
  @$pb.TagNumber(18)
  set pants($2.Pants v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasPants() => $_has(16);
  @$pb.TagNumber(18)
  void clearPants() => clearField(18);
  @$pb.TagNumber(18)
  $2.Pants ensurePants() => $_ensure(16);

  @$pb.TagNumber(19)
  Person_Embed_Double get double_19 => $_getN(17);
  @$pb.TagNumber(19)
  set double_19(Person_Embed_Double v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasDouble_19() => $_has(17);
  @$pb.TagNumber(19)
  void clearDouble_19() => clearField(19);
  @$pb.TagNumber(19)
  Person_Embed_Double ensureDouble_19() => $_ensure(17);
}

class Company extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Company', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'revenue', $pb.PbFieldType.OF)
    ..m<$fixnum.Int64, $core.String>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flags', entryClassName: 'Company.FlagsEntry', keyFieldType: $pb.PbFieldType.O6, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pdelta_tests'))
    ..aOM<Person>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ceo', subBuilder: Person.create)
    ..hasRequiredFields = false
  ;

  Company._() : super();
  factory Company() => create();
  factory Company.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Company.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Company clone() => Company()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Company copyWith(void Function(Company) updates) => super.copyWith((message) => updates(message as Company)); // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Case', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<Item>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: Item.create)
    ..m<$fixnum.Int64, $core.String>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flags', entryClassName: 'Case.FlagsEntry', keyFieldType: $pb.PbFieldType.O6, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pdelta_tests'))
    ..hasRequiredFields = false
  ;

  Case._() : super();
  factory Case() => create();
  factory Case.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Case.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Case clone() => Case()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Case copyWith(void Function(Case) updates) => super.copyWith((message) => updates(message as Case)); // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Item', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..aOS(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOB(34, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done')
    ..pPS(35, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flags')
    ..hasRequiredFields = false
  ;

  Item._() : super();
  factory Item() => create();
  factory Item.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Item.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Item clone() => Item()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Item copyWith(void Function(Item) updates) => super.copyWith((message) => updates(message as Item)); // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Chooser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'str')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dbl', $pb.PbFieldType.OD)
    ..aOM<Item>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itm', subBuilder: Item.create)
    ..hasRequiredFields = false
  ;

  Chooser._() : super();
  factory Chooser() => create();
  factory Chooser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chooser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Chooser clone() => Chooser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Chooser copyWith(void Function(Chooser) updates) => super.copyWith((message) => updates(message as Chooser)); // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ApplyTestCase', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'solo')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<$3.Op>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'op', subBuilder: $3.Op.create)
    ..aOM<$4.Any>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: $4.Any.create)
    ..aOM<$4.Any>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expected', subBuilder: $4.Any.create)
    ..hasRequiredFields = false
  ;

  ApplyTestCase._() : super();
  factory ApplyTestCase() => create();
  factory ApplyTestCase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApplyTestCase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApplyTestCase clone() => ApplyTestCase()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApplyTestCase copyWith(void Function(ApplyTestCase) updates) => super.copyWith((message) => updates(message as ApplyTestCase)); // ignore: deprecated_member_use
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
  $3.Op get op => $_getN(2);
  @$pb.TagNumber(3)
  set op($3.Op v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOp() => $_has(2);
  @$pb.TagNumber(3)
  void clearOp() => clearField(3);
  @$pb.TagNumber(3)
  $3.Op ensureOp() => $_ensure(2);

  @$pb.TagNumber(4)
  $4.Any get data => $_getN(3);
  @$pb.TagNumber(4)
  set data($4.Any v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => clearField(4);
  @$pb.TagNumber(4)
  $4.Any ensureData() => $_ensure(3);

  @$pb.TagNumber(5)
  $4.Any get expected => $_getN(4);
  @$pb.TagNumber(5)
  set expected($4.Any v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpected() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpected() => clearField(5);
  @$pb.TagNumber(5)
  $4.Any ensureExpected() => $_ensure(4);
}

class TransformTestCase extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransformTestCase', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'solo')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<$3.Op>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'op1', subBuilder: $3.Op.create)
    ..aOM<$3.Op>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'op2', subBuilder: $3.Op.create)
    ..aOM<$4.Any>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: $4.Any.create)
    ..aOM<$4.Any>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expected', subBuilder: $4.Any.create)
    ..aOM<$4.Any>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expected1', subBuilder: $4.Any.create)
    ..aOM<$4.Any>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expected2', subBuilder: $4.Any.create)
    ..hasRequiredFields = false
  ;

  TransformTestCase._() : super();
  factory TransformTestCase() => create();
  factory TransformTestCase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransformTestCase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransformTestCase clone() => TransformTestCase()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransformTestCase copyWith(void Function(TransformTestCase) updates) => super.copyWith((message) => updates(message as TransformTestCase)); // ignore: deprecated_member_use
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
  $3.Op get op1 => $_getN(2);
  @$pb.TagNumber(3)
  set op1($3.Op v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOp1() => $_has(2);
  @$pb.TagNumber(3)
  void clearOp1() => clearField(3);
  @$pb.TagNumber(3)
  $3.Op ensureOp1() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.Op get op2 => $_getN(3);
  @$pb.TagNumber(4)
  set op2($3.Op v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOp2() => $_has(3);
  @$pb.TagNumber(4)
  void clearOp2() => clearField(4);
  @$pb.TagNumber(4)
  $3.Op ensureOp2() => $_ensure(3);

  @$pb.TagNumber(5)
  $4.Any get data => $_getN(4);
  @$pb.TagNumber(5)
  set data($4.Any v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasData() => $_has(4);
  @$pb.TagNumber(5)
  void clearData() => clearField(5);
  @$pb.TagNumber(5)
  $4.Any ensureData() => $_ensure(4);

  @$pb.TagNumber(6)
  $4.Any get expected => $_getN(5);
  @$pb.TagNumber(6)
  set expected($4.Any v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasExpected() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpected() => clearField(6);
  @$pb.TagNumber(6)
  $4.Any ensureExpected() => $_ensure(5);

  @$pb.TagNumber(7)
  $4.Any get expected1 => $_getN(6);
  @$pb.TagNumber(7)
  set expected1($4.Any v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasExpected1() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpected1() => clearField(7);
  @$pb.TagNumber(7)
  $4.Any ensureExpected1() => $_ensure(6);

  @$pb.TagNumber(8)
  $4.Any get expected2 => $_getN(7);
  @$pb.TagNumber(8)
  set expected2($4.Any v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasExpected2() => $_has(7);
  @$pb.TagNumber(8)
  void clearExpected2() => clearField(8);
  @$pb.TagNumber(8)
  $4.Any ensureExpected2() => $_ensure(7);
}

class ApplyTestItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ApplyTestItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<$3.Op>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'op', subBuilder: $3.Op.create)
    ..aOM<Person>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expected', subBuilder: Person.create)
    ..hasRequiredFields = false
  ;

  ApplyTestItem._() : super();
  factory ApplyTestItem() => create();
  factory ApplyTestItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApplyTestItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApplyTestItem clone() => ApplyTestItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApplyTestItem copyWith(void Function(ApplyTestItem) updates) => super.copyWith((message) => updates(message as ApplyTestItem)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApplyTestItem create() => ApplyTestItem._();
  ApplyTestItem createEmptyInstance() => create();
  static $pb.PbList<ApplyTestItem> createRepeated() => $pb.PbList<ApplyTestItem>();
  @$core.pragma('dart2js:noInline')
  static ApplyTestItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApplyTestItem>(create);
  static ApplyTestItem _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $3.Op get op => $_getN(1);
  @$pb.TagNumber(2)
  set op($3.Op v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOp() => clearField(2);
  @$pb.TagNumber(2)
  $3.Op ensureOp() => $_ensure(1);

  @$pb.TagNumber(3)
  Person get expected => $_getN(2);
  @$pb.TagNumber(3)
  set expected(Person v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpected() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpected() => clearField(3);
  @$pb.TagNumber(3)
  Person ensureExpected() => $_ensure(2);
}

class ReduceTestItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReduceTestItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pdelta_tests'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<Person>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: Person.create)
    ..aOM<$3.Op>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'op1', subBuilder: $3.Op.create)
    ..aOM<$3.Op>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'op2', subBuilder: $3.Op.create)
    ..aOM<$3.Op>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reduced', subBuilder: $3.Op.create)
    ..hasRequiredFields = false
  ;

  ReduceTestItem._() : super();
  factory ReduceTestItem() => create();
  factory ReduceTestItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReduceTestItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReduceTestItem clone() => ReduceTestItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReduceTestItem copyWith(void Function(ReduceTestItem) updates) => super.copyWith((message) => updates(message as ReduceTestItem)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReduceTestItem create() => ReduceTestItem._();
  ReduceTestItem createEmptyInstance() => create();
  static $pb.PbList<ReduceTestItem> createRepeated() => $pb.PbList<ReduceTestItem>();
  @$core.pragma('dart2js:noInline')
  static ReduceTestItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReduceTestItem>(create);
  static ReduceTestItem _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  Person get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(Person v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
  @$pb.TagNumber(2)
  Person ensureData() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.Op get op1 => $_getN(2);
  @$pb.TagNumber(3)
  set op1($3.Op v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOp1() => $_has(2);
  @$pb.TagNumber(3)
  void clearOp1() => clearField(3);
  @$pb.TagNumber(3)
  $3.Op ensureOp1() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.Op get op2 => $_getN(3);
  @$pb.TagNumber(4)
  set op2($3.Op v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOp2() => $_has(3);
  @$pb.TagNumber(4)
  void clearOp2() => clearField(4);
  @$pb.TagNumber(4)
  $3.Op ensureOp2() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.Op get reduced => $_getN(4);
  @$pb.TagNumber(5)
  set reduced($3.Op v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasReduced() => $_has(4);
  @$pb.TagNumber(5)
  void clearReduced() => clearField(5);
  @$pb.TagNumber(5)
  $3.Op ensureReduced() => $_ensure(4);
}

