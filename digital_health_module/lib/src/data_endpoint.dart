part of '../main.dart';

//EXAMPLE WITH Memory 
//https://github.com/cph-cachet/carp.sensing-flutter/wiki/5.-Extending-CARP-Mobile-Sensing

/// Holds information about free memory on the phone.
@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class FreeMemory extends Data {
  static const dataType = DeviceSamplingPackage.FREE_MEMORY;

  /// Amount of free physical memory in bytes.
  int? freePhysicalMemory;

  /// Amount of free virtual memory in bytes.
  int? freeVirtualMemory;

  FreeMemory([this.freePhysicalMemory, this.freeVirtualMemory]) : super();

  @override
  Function get fromJsonFunction => _$FreeMemoryFromJson;
  factory FreeMemory.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as FreeMemory;
  @override
  Map<String, dynamic> toJson() => _$FreeMemoryToJson(this);

  @override
  String toString() =>
      '${super.toString()}, physical: $freePhysicalMemory, virtual: $freeVirtualMemory';
}
//TODO API med data
