// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui';
import 'package:blog_app/homepage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:random_string/random_string.dart';

class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  File? image;
  final picker = ImagePicker();
  Reference Firebaseref = FirebaseStorage.instance.ref().child('Blogs');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool showSpinner = false;
  //
  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController authorController = new TextEditingController();

  Future getImageGallery() async {
    final pickedFIle = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFIle != null) {
        image = File(pickedFIle.path);
      } else {
        print('No image selected');
      }
    });
  }

  Future getImageCamera() async {
    final pickedFIle = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFIle != null) {
        image = File((pickedFIle.path));
      } else {
        print('No image selected');
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImageCamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Camera',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.photo_library_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'CSI ',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Assignment',
                style: TextStyle(color: Colors.white, fontSize: 22),
              )
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                // uploadBlog();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.file_upload_outlined)),
            )
          ],
        ),
        body: InkWell(
          onTap: () {
            dialog(context);
          },
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    image != null
                        ? ClipRRect(
                            child: Container(
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width * .6,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              margin: EdgeInsets.symmetric(vertical: 24),
                              child: Center(
                                child: Text(
                                  'Image Successfully added',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            // Image.file(
                            //   image!.absolute,
                            //   height: MediaQuery.of(context).size.height * .3,
                            //   width: MediaQuery.of(context).size.width * .6,
                            // ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * .3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            margin: EdgeInsets.symmetric(vertical: 24),
                            width: MediaQuery.of(context).size.width * .6,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                            ),
                          ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Image Title",
                            labelStyle: TextStyle(color: Colors.red[300]),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Title should not be Blank";
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: authorController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Description",
                            labelStyle: TextStyle(color: Colors.red[300]),
                            hintText: 'Image Description',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Description should not be Blank";
                            }
                          },
                        ),
                      ],
                    )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
