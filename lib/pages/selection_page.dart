import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/pages/camera_hair_page.dart';
import 'package:healthy/pages/camera_skin_page.dart';
import 'package:healthy/pages/profile_page.dart';
import 'package:healthy/pages/select_report_page.dart';
import 'package:healthy/pages/splash_page.dart';
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/util.dart' as util;

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                IconButton(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    size: 35,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => Get.to(() => ProfilePage()),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            SizedBox(height: 25),
            Column(
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
                          SizedBox(
                            height: 85,
                            width: 85,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/img/hair.jpg'),
                            ),
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
                          SizedBox(
                            height: 85,
                            width: 85,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/img/skin.jpg'),
                            ),
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
                  onPressed: () => Get.to(() => SelectReportPage()),
                  child: Text('View Reports'),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ],
          padding: const EdgeInsets.all(dimens.insetL),
        ),
      ),
    );
  }

  Future<void> _onSignOut(BuildContext context) async {
    final confirmed = await util.showYesNoDialog(
        context, 'Are you sure you want to sign out?');
    if (confirmed ?? false) {
      await repository.signOut();
      Get.offAll(() => SplashPage());
    }
  }
}
