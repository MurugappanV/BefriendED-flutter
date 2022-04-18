import 'dart:developer';

import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/login/cubit/login_cubit.dart';
import 'package:befriended_flutter/app/widget/bouncing_button.dart';
import 'package:befriended_flutter/app/widget/snack_bar.dart';
import 'package:befriended_flutter/firebase/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

// class OTPScreen extends StatelessWidget {
//   const OTPScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<LoginCubit>(
//           create: (context) =>
//               LoginCubit(localStorage: context.read<LocalStorage>()),
//         ),
//       ],
//       child: const OTPScreenView(),
//     );
//   }
// }

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  void verifyOTP({String? pin}) {
    final smsOTP = pin ?? context.read<LoginCubit>().state.pin;
    // final verificationId = context.read<LoginCubit>().state.verificationId;

    if (smsOTP.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        singleLineSnackBar(context, 'Please enter OTP'),
      );
      return;
    }
    AuthProvider().verifyOTP(smsOTP, context, (User user) {
      Navigator.popUntil(context, (route) {
        log('-------++++++++++-----------');
        return route.isFirst;
      });
    });
  }

  //build method for UI Representation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Hero(
                tag: 'PhoneVerification',
                child: Text(
                  'Phone Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Please enter OTP',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 30,
              ),
              const Spacer(flex: 1),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                  verifyOTP(pin: pin);
                },
                onChanged: (value) {
                  context.read<LoginCubit>().pinChanged(value);
                },
                otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.1),
                    focusBorderColor: Colors.transparent,
                    enabledBorderColor: Colors.transparent),
              ),
              const Spacer(flex: 7),
              Hero(
                tag: 'PhoneVerificationButton',
                child: BouncingButton(
                  label: 'Verify OTP',
                  onPress: () {
                    verifyOTP();
                  },
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
