import 'package:befriended_flutter/animations/fade_up_animation.dart';
import 'package:befriended_flutter/app/launch/view/arrow_button.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            overlayImage(context, 1000, -50),
            overlayImage(context, 1200, -100),
            overlayImage(context, 1400, -150),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FadeUpAnimation(
                    delay: 1600,
                    child: Hero(
                      tag: 'BefriendEDTitle',
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                        child: Text(
                          'BefriendED',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FadeUpAnimation(
                    delay: 2100,
                    child: Text(
                      'we are always here for you!!',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                  const FadeUpAnimation(
                    delay: 2300,
                    child: ArrowButton(),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget overlayImage(BuildContext context, int delay, double top) {
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      top: top,
      left: 0,
      child: FadeUpAnimation(
        delay: delay,
        child: Container(
          width: width,
          height: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/one.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}