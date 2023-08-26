import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodex_app/app/constraints/permissions.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/user.dart';
import 'package:foodex_app/repository/remote_repository/remote_user_repository.dart';
import 'package:foodex_app/response/user_response.dart';
import 'package:foodex_app/screen/profile/widget/input_field.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
    super.key,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? uploadImage;

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController(text: "Test");
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();

  Widget showUploadedImage(File? pickedImageFile) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(color: Colors.purple, width: 3.0),
      ),
      color: Colors.red,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              pickedImageFile == null
                  ? Image.asset("images/upload.png")
                  : Image.file(
                      pickedImageFile,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          uploadImage = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      print("Failed to upload Image");
    }
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            insetPadding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    onPressed: () => loadImage(FROM_GALLERY),
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                ElevatedButton.icon(
                    onPressed: () => loadImage(FROM_CAMERA),
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera")),
              ],
            ),
          );
        });
  }

  FutureBuilder<UserProfileResponse?> setUserProfile() {
    return FutureBuilder<UserProfileResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userData = snapshot.data!.data!;
            return Container(
                padding: EdgeInsets.all(Dimensions.height10),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimensions.height25),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Update Profile',
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: Dimensions.font26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Center(
                              child: Container(
                                  padding: EdgeInsets.all(Dimensions.height20),
                                  child: Column(children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width: Dimensions.width30 * 4,
                                          height: Dimensions.height40 * 3,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius50 * 2),
                                            child: uploadImage == null
                                                ? Image.network(
                                                    userData.avatar!,
                                                    fit: BoxFit.cover,
                                                    width: double.maxFinite,
                                                  )
                                                : Image.file(
                                                    uploadImage!,
                                                    fit: BoxFit.cover,
                                                    width: double.maxFinite,
                                                  ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            height: Dimensions.height35,
                                            width: Dimensions.width35,
                                            decoration: BoxDecoration(
                                                color: AppColor.kSecondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius50 *
                                                            2)),
                                            child: GestureDetector(
                                              onTap: () {
                                                // showAlertDialog(context);
                                                // camera(context);
                                              },
                                              child: Icon(
                                                LineAwesomeIcons.camera,
                                                color: Colors.black,
                                                size: Dimensions.iconSize20,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          InputField(
                                            controller: _fullNameController,
                                            hintText: 'Name',
                                            prefixIcon: LineAwesomeIcons.user,
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                          InputField(
                                            controller: _emailController,
                                            hintText: 'Email',
                                            readOnly: true,
                                            prefixIcon:
                                                LineAwesomeIcons.envelope,
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                          InputField(
                                            controller: _phoneController,
                                            readOnly: true,
                                            hintText: 'Phone',
                                            prefixIcon: LineAwesomeIcons.phone,
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                          InputField(
                                            controller: _dobController,
                                            hintText: 'Date of Birth',
                                            prefixIcon:
                                                LineAwesomeIcons.calendar,
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1950),
                                                      //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2100));

                                              if (pickedDate != null) {
                                                print(
                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);
                                                print(
                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                setState(() {
                                                  _dobController.text =
                                                      formattedDate; //set output date to TextField value.
                                                });
                                              } else {}
                                            },
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                          PressButton(
                                            text: 'Update',
                                            press: () async {
                                              User user = User(
                                                  _fullNameController.text,
                                                  _emailController.text,
                                                  _dobController.text,
                                                  _phoneController.text,
                                                  "",
                                                  "");
                                              bool result = false;
                                              uploadImage == null
                                                  ? result =
                                                      await UserRepository()
                                                          .updateUserProfile(
                                                              user)
                                                  : result = await UserRepository()
                                                      .updateUserProfileWithImage(
                                                          user, uploadImage!);
                                              if (result == true) {
                                                ShowToast.displaySuccessToast(
                                                    context, "Profile Updated");
                                              } else {
                                                ShowToast.displayErrorToast(
                                                    context,
                                                    "Failed to update");
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])))))
                ]));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  void setInitialData() async {
    final response = await UserRepository().getUserProfile();
    _fullNameController.text = response!.data!.fullName!;
    _emailController.text = response.data!.email!;
    _phoneController.text = response.data!.phone!;
    _dobController.text = response.data!.dob!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: setUserProfile());
  }

  Widget camera(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.grey[300],
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      loadImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text('Camera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      loadImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Gallery'),
                  )
                ],
              ),
            ),
          );
        },
        child: const SizedBox(
          height: 200,
          width: double.infinity - 500,
          // child: _img == null
          //     ? Image.asset(
          //         'assets/images/upload.jpeg',
          //       )
          //     : Image.file(_img!),
        ),
      ),
    );
  }
}
