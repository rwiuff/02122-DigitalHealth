// lib/src/endpoints/data_endpoint.dart

class FreeMemory {
  // The type of data (can be any string that identifies this data type)
  static const String dataType = "FREE_MEMORY";

  // Amount of free physical memory in bytes
  int? freePhysicalMemory;

  // Amount of free virtual memory in bytes
  int? freeVirtualMemory;

  FreeMemory({this.freePhysicalMemory, this.freeVirtualMemory});

  // Method to create an instance from a JSON object
  factory FreeMemory.fromJson(Map<String, dynamic> json) {
    return FreeMemory(
      freePhysicalMemory: json['freePhysicalMemory'],
      freeVirtualMemory: json['freeVirtualMemory'],
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'freePhysicalMemory': freePhysicalMemory,
      'freeVirtualMemory': freeVirtualMemory,
    };
  }

  @override
  String toString() =>
      'FreeMemory(physical: $freePhysicalMemory, virtual: $freeVirtualMemory)';
}

enum CarpUploadMethod { stream, batch }
