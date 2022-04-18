part of 'app_cubit.dart';

enum NameStatus { initial, loading, success, failure }

enum PhoneNumberStatus { initial, loading, success, failure }

class AppState extends Equatable {
  const AppState({
    this.name = '',
    this.nameStatus = NameStatus.initial,
    this.phoneNumber = '',
    this.countryCode = '',
    this.phoneNumberStatus = PhoneNumberStatus.initial,
  });

  final String name;
  final NameStatus nameStatus;
  final String phoneNumber;
  final String countryCode;
  final PhoneNumberStatus phoneNumberStatus;

  AppState copyWith({
    String? name,
    NameStatus? nameStatus,
    String? phoneNumber,
    String? countryCode,
    PhoneNumberStatus? phoneNumberStatus,
  }) {
    return AppState(
      name: name ?? this.name,
      nameStatus: nameStatus ?? this.nameStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      phoneNumberStatus: phoneNumberStatus ?? this.phoneNumberStatus,
    );
  }

  @override
  List<Object?> get props =>
      [name, nameStatus, phoneNumber, countryCode, phoneNumberStatus];
}
