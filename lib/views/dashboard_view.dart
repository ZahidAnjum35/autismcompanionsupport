import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/enum/menu_action.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardView();
}

class _DashboardView extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autism Companion'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch(value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if(shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
                      (_) => false
                    );
                  } else {
                    return;
                  }
                  break;
                case MenuAction.profile:
                  Navigator.of(context).pushNamed(profileRoute);
                  break;
                case MenuAction.diagnosis:
                  Navigator.of(context).pushNamed(diagnosisRoute);
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.profile, 
                  child: Text('Profile'),
                ),
                PopupMenuItem<MenuAction>(
                  value: MenuAction.diagnosis, 
                  child: Text('Diagnosis'),
                ),
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, 
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
              children: [
               const Text('you haven\'t stated any intervention yet. Take Diagnosis test in order to get interventions recommendatoins'),
               TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(diagnosisRoute);
                },
                child: const Text('Start Test'),
               ),
               const Text("The Childhood Autism Rating Scale, 2nd Edition (CARS2) is designed as a clinical rating scale for the trained clinician to rate items indicative of Autism Spectrum Disorder (ASD) after direct observation of the child. The form is used with individuals of all ages and in both clincial and research settings."),
              ]
            ),
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            }, child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            }, child: const Text('Logout'),
          ),
        ]
      );
    }
  ).then((value) => value ?? false);
}