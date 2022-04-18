import 'package:befriended_flutter/app/login/login.dart';
import 'package:befriended_flutter/app/widget/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage>
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Text(
            'Connect with our buddy friend, for a friendly support',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          SvgPicture.asset(
            'assets/images/chat.svg',
            width: 200,
            height: 200,
            fit: BoxFit.scaleDown,
          ),
          const Spacer(),
          BouncingButton(
            label: 'Login',
            onPress: () {
              Navigator.push<dynamic>(context, _createRoute());
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              'Identity verification is needed to start the chat',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
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

  // void showLoginModel() {
  //   showModalBottomSheet<dynamic>(
  //     context: context,
  //     transitionAnimationController: _controller,
  //     builder: (context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height,
  //         child: Text("Your bottom sheet"),
  //       );
  //     },
  //   );
  // }
}
