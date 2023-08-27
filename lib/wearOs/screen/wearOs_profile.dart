import 'package:flutter/material.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
import 'package:foodex_app/response/user_response.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: getUserProfile(),
    ));
  }

  FutureBuilder<UserProfileResponse?> getUserProfile() {
    return FutureBuilder<UserProfileResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userData = snapshot.data!.data!;
            return Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userData.avatar!),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.fullName!,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userData.email!,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      userData.phone!,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
