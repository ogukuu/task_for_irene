import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/repository/settings_repository.dart';
import 'package:task_for_irene/src/settings/settings.dart';

class HiveSettingsRepository extends SettingsRepository {
  static String settingsBoxName = "settingsBox";
  static String key = "Settings";
  late Box<Settings> box;

  @override
  Settings read() {
    return box.get(key, defaultValue: Settings())!;
  }

  @override
  Future<void> write(Settings settings) async {
    await box.put(key, settings);
  }

  @override
  Future<void> init() async {
    if (GlobalVar.hiveIsNotInit) {
      GlobalVar.hiveIsNotInit = false;
      await Hive.initFlutter();
    }
    Hive.registerAdapter(SettingsAdapter());
    box = await Hive.openBox<Settings>(settingsBoxName);
    super.init();
  }

  @override
  Future<void> close() async {
    await box.compact();
    await box.close();
    super.close();
  }

  @override
  Future<void> clear() async {
    await box.clear();
    super.clear();
  }
}

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  Settings read(BinaryReader reader) {
    var themeModeName = reader.readString();
    var h = reader.readInt();
    var m = reader.readInt();
    return Settings.byThemeModeName(
        themeModeName: themeModeName,
        notificationTriggerTime: TimeOfDay(hour: h, minute: m));
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer.writeString(obj.themeModeName);
    writer.writeInt(obj.notificationTriggerTime.hour);
    writer.writeInt(obj.notificationTriggerTime.minute);
  }
}
