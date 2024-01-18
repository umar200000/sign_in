import 'package:hive/hive.dart';

class HiveRepo {
  final Box _box = Hive.box("data");

  safeMap(Map<String, String> map) {
    _box.put("malumot", map);
  }

  getMap() {
    Map<dynamic, dynamic> map =
        _box.get("malumot", defaultValue: <String, String>{});
    Map<String, String> map2 = {};
    map.forEach((key, value) {
      map2[key.toString()] = value.toString();
    });
    return map2;
  }

  safeName(List<String> list) {
    _box.put("names", list);
  }

  getNames() => _box.get("names", defaultValue: <String>[]);
}
