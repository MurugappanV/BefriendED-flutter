import 'package:befriended_flutter/local_storage/local_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required this.localStorage}) : super(const AppState());

  final LocalStorage localStorage;

  void nameChanged(String name) => emit(state.copyWith(name: name));

  void saveName() {
    localStorage.setName(state.name);
  }

  void getName() {
    emit(state.copyWith(nameStatus: NameStatus.loading));
    emit(
      state.copyWith(
        name: localStorage.getName() ?? '',
        nameStatus: NameStatus.success,
      ),
    );
  }

  void phoneNumberChanged(String phoneNumber) =>
      emit(state.copyWith(phoneNumber: phoneNumber));

  void savePhoneNumber() {
    localStorage.setPhoneNumber(state.phoneNumber, state.countryCode);
  }

  void countryCodeChanged(String countryCode) =>
      emit(state.copyWith(countryCode: countryCode));

  void getPhoneNumber() {
    emit(state.copyWith(phoneNumberStatus: PhoneNumberStatus.loading));
    emit(
      state.copyWith(
        phoneNumber: localStorage.getPhoneNumber() ?? '',
        countryCode: localStorage.getCountryCode() ?? '',
        phoneNumberStatus: PhoneNumberStatus.success,
      ),
    );
  }
  // void getCountryList(String data) {
  //   final countryList = parseJson(data);
  //   if (countryList.isNotEmpty) {
  //     emit(
  //       AppState(
  //         countryList: countryList,
  //         selectedCountryData: countryList[0],
  //       ),
  //     );
  //   }
  // }
}
