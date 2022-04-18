import 'dart:developer';

import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/chat/view/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomePageStatus { home, chat, blog, setting }

Map<HomePageStatus, Function> homePages = {
  HomePageStatus.home: () => Center(
        child: Text('First Page'),
        key: ValueKey(1),
      ),
  HomePageStatus.chat: () => ChatPage(key: ValueKey(2)),
  HomePageStatus.blog: () => Center(
        child: Text('Third Page'),
        key: ValueKey(3),
      ),
  HomePageStatus.setting: () => Center(
        child: Text('Fourth Page'),
        key: ValueKey(4),
      ),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
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
            child: _selectedPageWidget,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 7,
          color: Theme.of(context).colorScheme.primary,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  HomePageStatus.home == _selectedPage
                      ? Icons.home_rounded
                      : Icons.home_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 25,
                ),
                onPressed: () {
                  onTapped(HomePageStatus.home, 1);
                },
              ),
              IconButton(
                icon: Icon(
                  HomePageStatus.chat == _selectedPage
                      ? Icons.question_answer_rounded
                      : Icons.question_answer_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  onTapped(HomePageStatus.chat, 2);
                },
              ),
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.onPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {},
                ),
              ),
              IconButton(
                icon: Icon(
                  HomePageStatus.blog == _selectedPage
                      ? Icons.space_dashboard_rounded
                      : Icons.space_dashboard_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  onTapped(HomePageStatus.blog, 3);
                },
              ),
              IconButton(
                icon: Icon(
                  HomePageStatus.setting == _selectedPage
                      ? Icons.manage_accounts_rounded
                      : Icons.manage_accounts_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  onTapped(HomePageStatus.setting, 4);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapped(HomePageStatus page, int index) {
    setState(() {
      _selectedPage = page;
      _selectedPageWidget = homePages[page]?.call() as Widget;
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
