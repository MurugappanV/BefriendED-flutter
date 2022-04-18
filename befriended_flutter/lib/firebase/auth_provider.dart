import 'dart:developer';

import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/widget/snack_bar.dart';
import 'package:befriended_flutter/firebase/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthProvider with ChangeNotifier {
  factory AuthProvider() {
    return _singleton;
  }

  AuthProvider._internal();

  static final AuthProvider _singleton = AuthProvider._internal();

  final _firebaseAuth = FirebaseAuth.instance;
  String? verificationId;
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> verifyPhone(
      String mobileNumber, BuildContext context, Function callBack) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          log('---------- verified ------------');
        },
        verificationFailed: (FirebaseAuthException e) {
          log('---------- failed ------------');
          handleError(e, context);
          log(e.message ?? '');
          log(e.code);
          // snack bar for valid phone number
        },
        codeSent: (String verificationId, int? resendToken) {
          log('---------- sent ------------');
          ScaffoldMessenger.of(context).showSnackBar(
            singleLineSnackBar(context, 'OTP sent !'),
          );
          this.verificationId = verificationId;
          callBack();
          // Navigate to OTP screen with verificationId
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log('---------- timeout ------------');
          this.verificationId = verificationId;
        },
      );
    } catch (e) {
      log('%%%%%%%%% error %%%%%%%%%');
      log(e.toString());
      handleError(e as FirebaseException, context);
    }
  }

  void verifyOTP(String otp, BuildContext context, Function(User) callBack) {
    log(verificationId ?? '');
    log(otp);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId ?? '',
        smsCode: otp,
      );

      _firebaseAuth.signInWithCredential(credential).then(
        (value) {
          log('+++++++++signedIn++++++++');
          log(value.toString());
          log(value.user?.uid ?? '');
          log(_firebaseAuth.currentUser?.uid ?? '');
          if (value.user != null) {
            callBack(value.user!);
            addUser(value.user!, context);
          }
        },
        onError: (dynamic e) {
          log('+++++++++++++++++');
          log(e.toString());
          log(e.code.toString());
          handleError(e as FirebaseException, context);
        },
      );
    } catch (e) {
      log('##### error ######');
      handleError(e as FirebaseException, context);
    }
  }

  Future<void> addUser(User user, BuildContext context) async {
    final appState = context.read<AppCubit>().state;
    final QuerySnapshot result = await _firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .where(FirestoreConstants.id, isEqualTo: user.uid)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isEmpty) {
      // Writing data to server because here is a new user
      await _firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .doc(user.uid)
          .set(
            {
              FirestoreConstants.name: appState.name,
              FirestoreConstants.phoneNumber: appState.phoneNumber,
              FirestoreConstants.countryCode: appState.countryCode,
              FirestoreConstants.id: user.uid,
              'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
              FirestoreConstants.chattingWith: null,
            } as Map<String, String>,
          );

      // Write data to local storage
      // User? currentUser = user;
      // await prefs.setString(FirestoreConstants.id, currentUser.uid);
      // await prefs.setString(FirestoreConstants.nickname, currentUser.displayName ?? "");
      // await prefs.setString(FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
    } else {
      // Already sign up, just get data from firestore
      // DocumentSnapshot documentSnapshot = documents[0];
      // UserChat userChat = UserChat.fromDocument(documentSnapshot);
      // Write data to local
      // await prefs.setString(FirestoreConstants.id, userChat.id);
      // await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
      // await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
      // await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
    }
    // _status = Status.authenticated;
    // notifyListeners();
    // return true;
  }

  void handleError(FirebaseException e, BuildContext context) {
    if (e.code == 'missing-phone-number' || e.code == 'invalid-phone-number') {
      ScaffoldMessenger.of(context).showSnackBar(
        singleLineSnackBar(context, 'Please enter valid phone number'),
      );
    } else if (e.code == 'missing-verification-code' ||
        e.code == 'invalid-verification-code') {
      ScaffoldMessenger.of(context).showSnackBar(
        singleLineSnackBar(context, 'Please enter valid OTP'),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        singleLineSnackBar(context, 'Please contact our support'),
      );
    }
  }

  String? getCurrentUserId() {
    final user = _firebaseAuth.currentUser;
    return user?.uid;
  }
}
