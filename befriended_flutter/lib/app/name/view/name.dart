import 'package:befriended_flutter/animations/fade_up_animation.dart';
import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/home/home.dart';
import 'package:befriended_flutter/app/launch/launch.dart';
import 'package:befriended_flutter/app/widget/bouncing_button.dart';
import 'package:befriended_flutter/app/widget/snack_bar.dart';
import 'package:befriended_flutter/app/widget/text_field.dart';
import 'package:befriended_flutter/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamePage extends StatelessWidget {
  const NamePage({Key? key}) : super(key: key);

  void onPress(BuildContext context) {
    final name = context.read<AppCubit>().state.name;
    if (name.trim().isNotEmpty) {
      context.read<AppCubit>().saveName();
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder<Null>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        singleLineSnackBar(context, 'Please enter your name'),
      );
    }
  }

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
              Hero(
                tag: 'BefriendEDTitle',
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                  child: Text(
                    'BefriendED',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FadeUpAnimation(
                delay: 500,
                child: Text(
                  'Nice to meet you! what should i call you?',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              FadeUpAnimation(
                delay: 800,
                child: BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return MyTextField(
                      label: 'Your name',
                      value: state.name,
                      onChanged: (value) {
                        context.read<AppCubit>().nameChanged(value);
                      },
                    );
                  },
                ),
              ),
              const Spacer(),
              FadeUpAnimation(
                delay: 900,
                child: BouncingButton(
                  label: 'Continue',
                  onPress: () => onPress(context),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
