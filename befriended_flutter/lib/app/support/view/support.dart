import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/login/login.dart';
import 'package:befriended_flutter/app/support/view/support_request.dart';
import 'package:befriended_flutter/app/widget/bouncing_button.dart';
import 'package:befriended_flutter/app/widget/delay_sizedbox.dart';
import 'package:befriended_flutter/app/widget/scroll_column_constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

//   @override
//   State<SupportPage> createState() => _SupportPageState();
// }

// class _SupportPageState extends State<SupportPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   initState() {
//     super.initState();
//     _controller = BottomSheet.createAnimationController(this);
//     _controller.duration = Duration(seconds: 1);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      // child: Text('secnd Page'),
      child: ScrollColumnConstraint(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Join us!',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Become a buddy friend and support in our mission',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                DealySizedBox(
                  width: 200,
                  height: 200,
                  child: SvgPicture.asset(
                    'assets/images/support.svg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                if (state.isLoggedIn) {
                  return Column(
                    children: <Widget>[
                      BouncingButton(
                        label: 'Join',
                        onPress: () {
                          CupertinoScaffold.showCupertinoModalBottomSheet<
                              String>(
                            context: context,
                            expand: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return SupportRequest();
                            },
                            shadow: BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 0,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                            ),
                            // duration: Duration(milliseconds: 500),
                          );
                        },
                      ),
                    ],
                  );
                }
                return Column(
                  children: <Widget>[
                    BouncingButton(
                      label: 'Login',
                      onPress: () {
                        Navigator.push<dynamic>(context, _createRoute());
                      },
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Text(
                        'Identity verification is needed to become a buddy friend',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder<Null>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginScreen(),
      transitionDuration: const Duration(seconds: 1),
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
    );
  }
}
