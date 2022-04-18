import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/home/home.dart';
import 'package:befriended_flutter/app/launch/launch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashState();
}

// Country picker state class
class _SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final appState = context.read<AppCubit>().state;
    if (appState.nameStatus == NameStatus.success) {
      SchedulerBinding.instance?.addPostFrameCallback(
        (_) {
          navigateNextPage(appState.name);
        },
      );
    }
  }

  void navigateNextPage(String name) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder<Null>(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                opacity: animation.value,
                child: name.isNotEmpty ? const HomePage() : const LaunchPage(),
              );
            },
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) {
        return previous.nameStatus != current.nameStatus;
      },
      listener: (context, state) {
        if (state.nameStatus == NameStatus.success) {
          navigateNextPage(state.name);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotateMultiple,
                    colors: [Theme.of(context).colorScheme.onPrimary],
                    strokeWidth: 2,
                    // backgroundColor: Colors.black,
                    // pathBackgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
