import 'package:flutter/material.dart';

class CommonMenu extends StatefulWidget {
  const CommonMenu({
    Key? key,
    // required this.selectedPage,
    // required this.onTapped,
  }) : super(key: key);

  // final HomePageStatus selectedPage;
  // final Function(HomePageStatus, int) onTapped;

  @override
  State<CommonMenu> createState() => _CommonMenuState();
}

class _CommonMenuState extends State<CommonMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.70,
      padding: const EdgeInsetsDirectional.fromSTEB(25, 50, 20, 50),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildMenu(
              text: 'Connect with a buddy',
              iconData: Icons.link_rounded,
              onPress: () {},
            ),
            const SizedBox(
              height: 50,
            ),
            buildMenu(
              text: 'Discuss now',
              iconData: Icons.keyboard_double_arrow_right_rounded,
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenu({
    required String text,
    required IconData iconData,
    required Function onPress,
  }) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 15),
          // padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: IconButton(
            icon: Icon(
              iconData,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {},
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
