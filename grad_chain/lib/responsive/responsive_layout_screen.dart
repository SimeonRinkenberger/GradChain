import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    // context come from State<ResponsiveLayout>
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
          return widget.webScreenLayout;
        }
        // mobile screen
        return widget.mobileScreenLayout;
      },
    );
  }
}
