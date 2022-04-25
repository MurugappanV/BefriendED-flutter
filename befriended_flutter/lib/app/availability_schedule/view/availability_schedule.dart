import 'package:befriended_flutter/animations/fade_animation.dart';
import 'package:befriended_flutter/app/app_cubit/app_cubit.dart';
import 'package:befriended_flutter/app/availability_schedule/view/schedule_selectoion.dart';
import 'package:befriended_flutter/app/home/home.dart';
import 'package:befriended_flutter/app/launch/launch.dart';
import 'package:befriended_flutter/app/name/name.dart';
import 'package:befriended_flutter/app/widget/delay_sizedbox.dart';
import 'package:befriended_flutter/firebase/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailabilitySchedule extends StatefulWidget {
  const AvailabilitySchedule({
    Key? key,
    // required this.selectedPage,
    // required this.onTapped,
  }) : super(key: key);

  // final HomePageStatus selectedPage;
  // final Function(HomePageStatus, int) onTapped;

  @override
  State<AvailabilitySchedule> createState() => _AvailabilityScheduleState();
}

class _AvailabilityScheduleState extends State<AvailabilitySchedule> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.70,
      padding: const EdgeInsetsDirectional.fromSTEB(25, 25, 20, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Availablility schedule',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Time Zone',
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: CupertinoPicker(
                itemExtent: 45,
                onSelectedItemChanged: (index) {},
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'America/New York',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    'America/Middle',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'America/Chichago',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DealySizedBox(
              child: FadeAnimation(
                child: Text(
                  'Press and drag slots to select',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.left,
                ),
                delay: 50,
              ),
              delay: 350,
            ),
            DealySizedBox(
              child: FadeAnimation(
                child: ScheduleSelection(),
                delay: 50,
              ),
              delay: 350,
            ),
            // ScheduleSelection(),
          ],
        ),
      ),
    );
  }
}
