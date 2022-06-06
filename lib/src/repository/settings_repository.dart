import 'package:task_for_irene/src/settings/settings.dart';

abstract class SettingsRepository {
  Settings read();
  Future<void> write(Settings settings);
  Future<void> init() async {}
  Future<void> close() async {}
  Future<void> clear() async {}
}
