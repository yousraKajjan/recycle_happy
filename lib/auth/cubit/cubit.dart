import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle_happy_custom/auth/cubit/state.dart';
import 'package:recycle_happy_custom/resources/util.dart';
import 'package:uuid/uuid.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  XFile? profilePic;
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  bool obscureText = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final TextEditingController numberPhoneController = TextEditingController();
  Uint8List? image;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final uuid = const Uuid().v4();

  // uploadProfilePic(XFile image) {
  //   profilePic = image;
  //   emit(UploadProfilePic());
  // }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = storage
        .ref()
        .child(childName)
        .child('${FirebaseAuth.instance.currentUser!.uid}jpg');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void selectImage(context) async {
    Uint8List img = await pickImage(ImageSource.gallery, context);
    image = img;
    emit(SelectImageState());
  }

  Future<String> sinup(context) async {
    String resp = "Some Error Occurred";
    try {
      emit(SignUpLoading());
      form.currentState?.validate();
      if (form.currentState?.validate() ?? false) {
        String email = emailController.text;
        String name = nameController.text;
        String numberPhone = numberPhoneController.text;
        // String imagUrl = await uploadImageToStorage('profileImage', image!);
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        print(result);
        //firstore firebase
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              // .doc(uuid)
              .set({
            // 'id': uuid,
            "name": name,
            "email": email,
            "numberphone": numberPhone,
            // 'imageLink': imagUrl,
            "createdAt": Timestamp.now(),
          });
          print("finish write");
        } else {
          print('non fire store');
        }
        Navigator.pushNamedAndRemoveUntil(
            context, "/home", ModalRoute.withName('/'));
        emit(SignUpSuccess());
      }
    } catch (e) {
      if (e is FirebaseException) {
        emit(SignUpFailure(errMessage: e.message!));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? "")));
      }
    }
    return resp;
  }
}
