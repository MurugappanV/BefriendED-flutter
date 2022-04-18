import 'package:befriended_flutter/animations/fade_up_animation.dart';
import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/widget/bouncing_button.dart';
import 'package:befriended_flutter/app/widget/snack_bar.dart';
import 'package:befriended_flutter/app/widget/text_field.dart';
import 'package:befriended_flutter/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Image(image: AssetImage('assets/images/chat.svg')),
          const Spacer(),
          FadeUpAnimation(
            delay: 900,
            child: BouncingButton(
              label: 'Chat',
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
