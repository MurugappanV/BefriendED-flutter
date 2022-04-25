import 'dart:developer';

import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/chat/view/chat.dart';
import 'package:befriended_flutter/app/home/view/bottom_navigator.dart';
import 'package:befriended_flutter/app/hometab/view/hometab.dart';
import 'package:befriended_flutter/app/setting/view/setting.dart';
import 'package:befriended_flutter/app/support/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum HomePageStatus { home, chat, blog, setting }

Map<HomePageStatus, Function> homePages = {
  HomePageStatus.home: () => const HomeTabPage(key: ValueKey(1)),
  HomePageStatus.chat: () => const ChatPage(key: ValueKey(2)),
  HomePageStatus.blog: () => const SupportPage(key: ValueKey(3)),
  HomePageStatus.setting: () => const SettingsPage(key: ValueKey(4)),
};

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<LoginCubit>(
//           create: (context) =>
//               LoginCubit(localStorage: context.read<LocalStorage>()),
//         ),
//       ],
//       child: const HomePageView(),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  HomePageStatus _selectedPage = HomePageStatus.home;
  int _selectedIndex = 1;
  int _previousIndex = 0;
  Widget? _selectedPageWidget =
      homePages[HomePageStatus.home]?.call() as Widget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) {
        return true;
      },
      listener: (context, state) {},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CupertinoScaffold(
          transitionBackgroundColor: Theme.of(context).colorScheme.primary,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      final inAnimation =
                          Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                              .animate(animation);
                      final outAnimation =
                          Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                              .animate(animation);
                      Animation<Offset> anim;
                      if (_previousIndex < _selectedIndex) {
                        //right to left
                        log(child.key.toString());
                        log(ValueKey(_selectedIndex).toString());
                        if (child.key == ValueKey(_selectedIndex)) {
                          print("in");
                          anim = inAnimation;
                        } else {
                          print("out");
                          anim = outAnimation;
                        }
                      } else {
                        //left to right
                        if (child.key == ValueKey(_selectedIndex)) {
                          anim = outAnimation;
                        } else {
                          anim = inAnimation;
                        }
                      }

                      return SlideTransition(
                        position: anim,
                        child: child,
                      );
                    },
                    // layoutBuilder: (currentChild, _) {
                    //   return currentChild;
                    // },
                    child: homePages[_selectedPage]?.call() as Widget,
                  ),
                ),
                MyBottomNavigator(
                  selectedPage: _selectedPage,
                  onTapped: onTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapped(HomePageStatus page, int index) {
    setState(() {
      _selectedPage = page;
      // _selectedPageWidget = homePages[page]?.call() as Widget;
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });
  }
}

// floatingActionButton: SizedBox(
        //   width: 50,
        //   height: 50,
        //   child: FittedBox(
        //     child: FloatingActionButton(
        //       backgroundColor: Theme.of(context).colorScheme.onPrimary,
        //       //Floating action button on Scaffold
        //       onPressed: () {
        //         //code to execute on button press
        //       },
        //       child: Icon(
        //         Icons.add_rounded,
        //         color: Theme.of(context).colorScheme.primary,
        //         size: 35,
        //       ), //icon inside button
        //     ),
        //   ),
        // ),
        // floatingActionButtonLocation: 
        // FloatingActionButtonLocation.centerDocked,
