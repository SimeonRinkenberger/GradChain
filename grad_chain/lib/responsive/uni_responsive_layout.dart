import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class UniResponsiveLayout extends StatefulWidget {
  final Widget UniWebScreen;
  final Widget UniMobileScreen;

  const UniResponsiveLayout({
    super.key,
    required this.UniWebScreen,
    required this.UniMobileScreen,
  });

  @override
  State<UniResponsiveLayout> createState() => _UniResponsiveLayoutState();
}

class _UniResponsiveLayoutState extends State<UniResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    // context come from State<UniResponsiveLayout>
    UserProvider _userProvider = Provider.of(context,
        listen:
            false); // listen is false so that it only refreshes the user data when we wanted it to, in this case when awaiting the method refreshUser()
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // web screen
          return widget.UniWebScreen;
        }
        // mobile screen
        return widget.UniMobileScreen;
      },
    );
  }
}
