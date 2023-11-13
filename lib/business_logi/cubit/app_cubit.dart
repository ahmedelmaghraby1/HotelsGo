import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  static AppCubit get(BuildContext context) => BlocProvider.of(context);
  AppCubit() : super(AppInitial());
  bool dateRangeIcon = false;
  String dateRangeText = "";
  int rooms = 1;
  int adults = 1;
  int children = 0;
  bool pets = false;

  Future<void> selectDateRange(BuildContext context) async {
    if (dateRangeIcon == true && dateRangeText != "") {
      dateRangeText = "";
      dateRangeIcon = !dateRangeIcon;
    } else {
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      DateTime startDate = DateTime.now();
      DateTime endDate = DateTime.now().add(const Duration(days: 7));
      final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024),
        initialDateRange: DateTimeRange(start: startDate, end: endDate),
      );

      if (picked != null &&
          picked != DateTimeRange(start: startDate, end: endDate)) {
        startDate = picked.start;
        endDate = picked.end;

        dateRangeText =
            "${dateFormat.format(startDate)} ==> ${dateFormat.format(endDate)}";
        dateRangeIcon = !dateRangeIcon;
      }
    }

    emit(ChooseDateRangeState());
  }

  void selectNationality() {
    emit(SelectNationalityState());
  }

  void allowPets(bool value) {
    pets = value;
    emit(AllowPetsState());
  }

  void addOrRemove(int type, IconData icon) {
    switch (type) {
      case 0:
        {
          switch (icon) {
            case Icons.remove:
              {
                if (rooms > 1) {
                  rooms--;
                } else {}
              }
            case Icons.add:
              {
                if (rooms < 4) {
                  rooms++;
                } else {}
              }
          }
        }
      case 1:
        {
          switch (icon) {
            case Icons.remove:
              {
                if (adults > 1) {
                  adults--;
                } else {}
              }
            case Icons.add:
              {
                if (adults < 4) {
                  adults++;
                } else {}
              }
          }
        }
      case 2:
        {
          switch (icon) {
            case Icons.remove:
              {
                if (children > 0) {
                  children--;
                } else {}
              }
            case Icons.add:
              {
                if (children < 4) {
                  children++;
                } else {}
              }
          }
        }
    }
    emit(AddOrRemoveState());
  }

  Color color(int type, IconData icon, BuildContext context) {
    if (type == 0) {
      if (icon == Icons.remove) {
        if (rooms == 1) {
          return Color.fromARGB(255, 195, 218, 236);
        } else {
          return Color.fromARGB(255, 5, 80, 137);
        }
      } else {
        if (rooms == 4) {
          return Color.fromARGB(255, 195, 218, 236);
        } else {
          return Color.fromARGB(255, 5, 80, 137);
        }
      }
    }
    if (type == 1) {
      if (icon == Icons.remove) {
        if (adults == 1) {
          return Color.fromARGB(255, 195, 218, 236);
        } else {
          return Color.fromARGB(255, 5, 80, 137);
        }
      } else {
        if (adults == 4) {
          return Color.fromARGB(255, 195, 218, 236);
        } else {
          return Color.fromARGB(255, 5, 80, 137);
        }
      }
    }
    if (type == 2) {
      if (icon == Icons.remove) {
        if (children == 0) {
          return Color.fromARGB(255, 195, 218, 236);
        } else {
          return Color.fromARGB(255, 5, 80, 137);
        }
      } else {
        if (children == 4) {
          return Color.fromARGB(255, 195, 218, 236);
        } else {
          return Color.fromARGB(255, 5, 80, 137);
        }
      }
    }
    emit(AddOrRemoveState());
    return Colors.black;
  }

  void reset(BuildContext context) {
    rooms = 1;
    adults = 1;
    children = 0;
    Navigator.pop(context);
    emit(ResetState());
  }
}
