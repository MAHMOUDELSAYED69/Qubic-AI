part of 'validation_cubit.dart';

@immutable
abstract class ValidationState {}

class ValidationInitial extends ValidationState {}

class EmailValidationSuccess extends ValidationState {}

class PasswordValidationSuccess extends ValidationState {}

class ConfirmPasswordValidationSuccess extends ValidationState {}
