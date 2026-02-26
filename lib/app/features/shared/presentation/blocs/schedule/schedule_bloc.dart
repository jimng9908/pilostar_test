import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(const ScheduleState()) {
    on<UpdateTimeEvent>((event, emit) {
      final newData = Map<String, Map<String, String>>.from(state.inputData);

      if (state.isSameScheduleEveryDay) {
        final days = [
          "Lunes",
          "Martes",
          "Miércoles",
          "Jueves",
          "Viernes",
          "Sábado",
          "Domingo"
        ];
        for (final day in days) {
          newData[day] = {
            ...(newData[day] ?? {}),
            event.type: event.time,
          };
        }
      } else {
        for (final day in newData.keys) {
          newData[day] = {
            ...(newData[day] ?? {}),
            event.type: event.time,
          };
        }
      }

      final allDaysSelected = newData.length == 7;
      emit(state.copyWith(
        inputData: newData,
        isSameScheduleEveryDay:
            allDaysSelected ? true : state.isSameScheduleEveryDay,
      ));
    });
    on<SaveSchedulesEvent>((event, emit) {
      final inputData = state.inputData;
      if (inputData.isEmpty) return;

      Map<String, String> hoursMap = {};
      String? currentRange;

      for (final day in inputData.keys) {
        final start = inputData[day]?['start'] ?? "--:--";
        final end = inputData[day]?['end'] ?? "--:--";
        if (start != "--:--" && end != "--:--") {
          final range = "$start-$end";
          hoursMap[day.toLowerCase()] = range;
          currentRange = range;
        }
      }

      if (hoursMap.isNotEmpty && currentRange != null) {
        final List<Map<String, String>> newGroups =
            List.from(state.savedGroups);
        bool merged = false;

        for (int i = 0; i < newGroups.length; i++) {
          final existingGroup = newGroups[i];
          if (existingGroup.isNotEmpty) {
            final firstRange = existingGroup.values.first;
            if (firstRange == currentRange) {
              newGroups[i] = {...existingGroup, ...hoursMap};
              merged = true;
              break;
            }
          }
        }

        if (!merged) {
          newGroups.add(hoursMap);
        }

        emit(state.copyWith(
          isEditing: false,
          savedGroups: newGroups,
          inputData: {}, // Limpiar para el siguiente grupo
          isSameScheduleEveryDay: false,
        ));
      }
    });

    on<DeleteGroupEvent>((event, emit) {
      final List<Map<String, String>> newGroups = List.from(state.savedGroups);
      if (event.index >= 0 && event.index < newGroups.length) {
        newGroups.removeAt(event.index);
        emit(state.copyWith(savedGroups: newGroups));
      }
    });

    on<EditGroupEvent>((event, emit) {
      final List<Map<String, String>> groups = List.from(state.savedGroups);
      if (event.index >= 0 && event.index < groups.length) {
        final Map<String, String> groupToEdit = groups.removeAt(event.index);

        final Map<String, Map<String, String>> newInputData = {};
        String firstDay = "Lunes";

        groupToEdit.forEach((day, range) {
          final times = range.split('-');
          if (times.length == 2) {
            final capitalizedDay = day[0].toUpperCase() + day.substring(1);
            newInputData[capitalizedDay] = {
              'start': times[0],
              'end': times[1],
            };
            firstDay = capitalizedDay;
          }
        });

        emit(state.copyWith(
          isEditing: true,
          savedGroups: groups,
          inputData: newInputData,
          selectedDay: firstDay,
        ));
      }
    });
    on<ToggleEditModeEvent>(
        (event, emit) => emit(state.copyWith(isEditing: event.isEditing)));
    on<InitializeScheduleEvent>(_onInitializeSchedule);
    on<SelectDayEvent>((event, emit) {
      debugPrint("SelectDayEvent: ${event.day}");
      debugPrint("Current InputData: ${state.inputData}");
      final newData = Map<String, Map<String, String>>.from(state.inputData);
      if (!newData.containsKey(event.day)) {
        newData[event.day] = <String, String>{'start': '08:00', 'end': '20:00'};
      }
      debugPrint("New InputData after selection: $newData");
      emit(state.copyWith(selectedDay: event.day, inputData: newData));
    });
    on<RemoveDayEvent>((event, emit) {
      final newData = Map<String, Map<String, String>>.from(state.inputData);
      newData.remove(event.day);
      emit(state.copyWith(
        inputData: newData,
        isSameScheduleEveryDay: false,
      ));
    });
    on<ToggleSameScheduleEvent>((event, emit) {
      final newState = state.copyWith(isSameScheduleEveryDay: event.isSame);

      // If turning on, we might want to sync current data based on the first day that has data
      if (event.isSame) {
        final newData = Map<String, Map<String, String>>.from(state.inputData);
        final days = [
          "Lunes",
          "Martes",
          "Miércoles",
          "Jueves",
          "Viernes",
          "Sábado",
          "Domingo"
        ];

        // Find first day with some data to use as template
        Map<String, String>? template;
        for (final d in days) {
          if (newData[d] != null && newData[d]!.isNotEmpty) {
            template = newData[d];
            break;
          }
        }

        if (template != null) {
          for (final d in days) {
            newData[d] = Map<String, String>.from(template);
          }
          emit(newState.copyWith(inputData: newData));
          return;
        }
      }
      debugPrint("groups3: ${newState.savedGroups}");

      emit(newState);
    });
  }

  void _onInitializeSchedule(
      InitializeScheduleEvent event, Emitter<ScheduleState> emit) {
    if (event.days.isEmpty) {
      emit(const ScheduleState());
      return;
    }

    // Agrupar días por sus horarios para crear los grupos
    final Map<String, Map<String, String>> groupsByTime = {};

    for (final day in event.days) {
      if (day.isOpen && day.openTime.isNotEmpty && day.closeTime.isNotEmpty) {
        final timeKey = "${day.openTime}-${day.closeTime}";
        if (!groupsByTime.containsKey(timeKey)) {
          groupsByTime[timeKey] = {};
        }
        groupsByTime[timeKey]![day.dayName.toLowerCase()] = timeKey;
      }
    }

    final List<Map<String, String>> savedGroups = groupsByTime.values.toList();

    emit(ScheduleState(
      isEditing: false,
      savedGroups: savedGroups,
      isInitialized: true,
    ));
  }
}
