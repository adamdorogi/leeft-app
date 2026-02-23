// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get routines => 'Routines';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get createRoutine => 'Create Routine';

  @override
  String get addExercises => 'Add Exercises';

  @override
  String muscleGroupNameFor(String muscleGroup) {
    String _temp0 = intl.Intl.selectLogic(
      muscleGroup,
      {
        'lowerBack': 'Lower Back',
        'hamstrings': 'Hamstrings',
        'glutes': 'Glutes',
        'chest': 'Chest',
        'triceps': 'Triceps',
        'shoulders': 'Shoulders',
        'upperBack': 'Upper Back',
        'lats': 'Lats',
        'biceps': 'Biceps',
        'forearms': 'Forearms',
        'abdominals': 'Abdominals',
        'quadriceps': 'Quadriceps',
        'traps': 'Traps',
        'calves': 'Calves',
        'cardio': 'Cardio',
        'neck': 'Neck',
        'adductors': 'Adductors',
        'fullBody': 'Full Body',
        'abductors': 'Abductors',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String equipmentNameFor(String equipment) {
    String _temp0 = intl.Intl.selectLogic(
      equipment,
      {
        'machine': 'Machine',
        'barbell': 'Barbell',
        'dumbbell': 'Dumbbell',
        'resistanceBand': 'Resistance Band',
        'suspension': 'Suspension',
        'kettlebell': 'Kettlebell',
        'plate': 'Plate',
        'none': 'None',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String get search => 'Search';

  @override
  String get equipment => 'Equipment';

  @override
  String get muscleGroups => 'Muscle Groups';

  @override
  String get replace => 'Replace';

  @override
  String get remove => 'Remove';

  @override
  String get notes => 'Notes';

  @override
  String get addSet => 'Add Set';

  @override
  String get superset => 'Superset';

  @override
  String get reps => 'Reps';

  @override
  String get kg => 'kg';
}
