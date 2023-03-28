import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_chain/utils/colors.dart';
//import 'package:grad_chain/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_chain/widgets/claim_card.dart';

class StuHomeScreen extends StatelessWidget {
  const StuHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),

      // HERE WE GET THE LIST OF OBJECT FROM FIRESTORE AND THEN POPULATE THE POSTCARD WIDGET
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => ClaimCard(
              // FIX THIS!!!!! ClaimCard needs to be changed
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
