part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ChooseDateRangeState extends AppState {}

final class SelectNationalityState extends AppState {}

final class AddOrRemoveState extends AppState {}

final class AllowPetsState extends AppState {}

final class ResetState extends AppState {}
