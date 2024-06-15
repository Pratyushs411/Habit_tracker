import 'package:flutter/material.dart';

import '../models/habit.dart';

bool isHabitCompleatedToday(List<DateTime> completedDays){
  final today = DateTime.now();

  return completedDays.any((date) =>
  date.year == today.year &&
      date.month == today.month &&
      date.day == today.day
  );
}

Map<DateTime, int> prepareHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (var habit in habits) {
    // Ensure completeDays is not null or empty
    if (habit.completedDays.isNotEmpty) {
      for (var date in habit.completedDays) {
        // Normalize the date to ignore time (consider only year, month, day)
        final normalizedDate = DateTime(date.year, date.month, date.day);

        // Update dataset: increment count if date already exists, otherwise initialize with 1
        if (dataset.containsKey(normalizedDate)) {
          dataset[normalizedDate] = dataset[normalizedDate]! + 1;
        } else {
          dataset[normalizedDate] = 1;
        }
      }
    }
  }

  return dataset;
}
