import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:json/json.dart';

main() async {
  const pubUrl = "https://pub.dartlang.org/api/packages/protobuf";
  var response = await http.get(Uri.parse(pubUrl));
  if (response.statusCode == 200) {
    PkgInfo info = PkgInfo.fromJson(json.decode(response.body));
    print('Package ${info.name}, latest is v${info.latest.pubspec.version}');
    print(info.latest.pubspec.description);
  } else {
    throw Exception('Failed to load package info');
  }

  final o1 = PkgPubspec(description: '', version: '', nested: []);

  o1.toJson();
}

@JsonCodable()
class PkgInfo {
  final String name;
  final PkgVersion latest;

  PkgInfo({required this.name, required this.latest});
}

@JsonCodable()
class PkgVersion {
  final String version;
  final PkgPubspec pubspec;

  PkgVersion({required this.version, required this.pubspec});
}

@JsonCodable()
class PkgPubspec {
  final String version;
  final String description;
  final List<List<Map<int, List<int?>>?>> nested;
  // final List<int?> list;

  PkgPubspec({
    required this.version,
    required this.description,
    required this.nested,
  });
}
