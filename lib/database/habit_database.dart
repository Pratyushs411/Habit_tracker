import 'package:fitness_tracker/models/app_settings.dart';
import 'package:fitness_tracker/models/habit.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fitness_tracker/models/habit.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  Future<void> readHabits() async {
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    notifyListeners();
  }

  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }


  final List<Habit> currentHabits = [];

  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;
    await isar.writeTxn(() => isar.habits.put(newHabit));
    print("Added habit: $newHabit");
    saveFirstLaunchDate();
    readHabits();
  }

  Future<void> updateHabitCompletion(bool isCompleted, int id) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        final today = DateTime.now();

        if (isCompleted) {
          if (!habit.completedDays.any((date) =>
          date.year == today.year &&
              date.month == today.month &&
              date.day == today.day)) {
            habit.completedDays.add(DateTime(today.year, today.month, today.day));
          }
        } else {
          habit.completedDays.removeWhere((date) =>
          date.year == today.year &&
              date.month == today.month &&
              date.day == today.day);
        }

        await isar.habits.put(habit);
      });

      print("Updated habit completion: $habit");
      readHabits();
    }
    saveFirstLaunchDate();
  }

  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(()async {
        habit.name = newName;
        await isar.habits.put(habit);
      });
    }
    saveFirstLaunchDate();
    readHabits();
  }

  Future<void> deleteHabit(int id) async{
    await isar.writeTxn(() async{
      await isar.habits.delete(id);
    });
    saveFirstLaunchDate();
    readHabits();
  }
}
