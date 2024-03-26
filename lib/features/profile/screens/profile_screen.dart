import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/profile/providers/user_profile_controller.dart';
import 'package:approvelt/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  void updateProfile() async {
    ref.read(userProfileStateProvider.notifier).updateProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = ref.read(userModelProvider);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    if (userModel.uidPhotoUrl != '')
                      const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              "http://via.placeholder.com/350x150")),
                    if (userModel.uidPhotoUrl == '')
                      const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/defaultprofile.png'))
                  ],
                ),
                Positioned(
                    left: 85,
                    bottom: -10,
                    child: IconButton(
                        onPressed: () async {
                          updateProfile();
                        },
                        icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            Text(
              userModel.name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(userModel.email),
            const SizedBox(
              height: 7,
            ),
            Container(
                width: 80,
                decoration: BoxDecoration(border: Border.all()),
                child: Center(
                    child: Text(
                  userModel.type,
                  style: const TextStyle(color: Colors.black),
                )))
          ],
        ),
      ),
    );
  }
}
