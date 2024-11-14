import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v4/screens/common/widget/custom_btn.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 현재 경로 가져오기
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF339B75),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35,
                ),
                CustomWhiteButton(
                  buttonName: 'Manage Crops',
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    children: [
                      CustomTextButton(
                        buttonName: 'My Page',
                        onPressed: () {},
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('|',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomTextButton(
                        buttonName: 'Sign Out',
                        onPressed: () {
                          context.go('/login');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              if (currentRoute != '/') {
                context.go('/');
              }
              Navigator.pop(context);  
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Price Info'),
            onTap: () {
              if (currentRoute != '/price_info') {
                context.go('/price_info');
              }
              Navigator.pop(context);  
            },
          ),
          ListTile(
            leading: Icon(Icons.eco),
            title: Text('Growh Info'),
            onTap: () {
              if (currentRoute != '/growth_info') {
                context.go('/growth_info');
              }
              Navigator.pop(context);  
            },
          ),
          ListTile(
            leading: Icon(Icons.agriculture),
            title: Text('Crop Info'),
            onTap: () {
              if (currentRoute != '/crop_info') {
                context.go('/crop_info');
              }
              Navigator.pop(context);  
            },
          ),
        ],
      ),
    );
  }
}
