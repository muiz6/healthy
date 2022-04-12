import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/pages/camera_hair_page.dart';
import 'package:healthy/pages/camera_skin_page.dart';
import 'package:healthy/pages/splash_page.dart';
import 'package:healthy/pages/view_report_page.dart';
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/dimens.dart' as dimens;

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(dimens.insetL),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    child: Text('Sign Out'),
                    onPressed: () => _onSignOut(context),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      )),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      strings.msgSelect,
                      style: textTheme.headline3,
                    ),
                    SizedBox(
                      height: dimens.insetL,
                    ),
                    InkWell(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(dimens.insetL),
                          child: Column(
                            children: [
                              Icon(
                                Icons.face,
                                size: 72,
                              ),
                              SizedBox(
                                height: dimens.insetM,
                              ),
                              Text(strings.hair),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => Get.to(() => CameraHairPage()),
                    ),
                    SizedBox(height: dimens.insetL),
                    InkWell(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(dimens.insetL),
                          child: Column(
                            children: [
                              Icon(
                                Icons.face_retouching_natural_sharp,
                                size: 72,
                              ),
                              SizedBox(
                                height: dimens.insetM,
                              ),
                              Text(strings.skin),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => Get.to(() => CameraSkinPage()),
                    ),
                    SizedBox(height: dimens.insetL),
                    ElevatedButton(
                      onPressed: () => Get.to(ViewReportPage()),
                      child: Text('View Reports'),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (builderContext) {
        return AlertDialog(
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(builderContext).pop(false),
              child: Text(
                'No',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(builderContext).pop(true),
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
    if (confirmed ?? false) {
      await repository.signOut();
      Get.offAll(() => SplashPage());
    }
  }
}
