import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/profile_Model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class ProfileScreen extends StatefulWidget {
  ProfileModel? profileData;
  ProfileScreen({Key? key, this.profileData}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late DatabaseHelper _databaseHelper;
  File? image;
  late XFile imageTempFile;
  bool imagePicked = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _aPaterno = TextEditingController();
  TextEditingController _aMaterno = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imagePermanent = await saveImagePermanently(image);
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        this.imageTempFile = image;
        this.imagePicked = true;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    if (widget.profileData != null) {
      print("Image");
      print(widget.profileData!.image!);
      _name.text = widget.profileData!.name!;
      _aPaterno.text = widget.profileData!.aPaterno!;
      _aMaterno.text = widget.profileData!.aMaterno!;
      _phoneNumber.text = widget.profileData!.phoneNumber.toString();
      _email.text = widget.profileData!.email!;
      image = widget.profileData?.image != ""
          ? new File(widget.profileData!.image!)
          : null;
    }

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    Form inputForm = Form(
      key: _formKey,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text('Select a image source'),
                      children: [
                        SimpleDialogOption(
                          child: Row(
                            children: [
                              Text('Camera'),
                              Spacer(),
                              Icon(Icons.camera_alt),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            pickImage(ImageSource.camera);
                          },
                        ),
                        SimpleDialogOption(
                          child: Row(
                            children: [
                              Text('Gallery'),
                              Spacer(),
                              Icon(Icons.photo_library),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            pickImage(ImageSource.gallery);
                          },
                        )
                      ],
                    );
                  });
            },
            child: image != null
                ? ClipOval(
                    child: Image.file(
                      image!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  )
                : FlutterLogo(
                    size: 100,
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a valid data";
              }
              return null;
            },
            controller: _name,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Set your name',
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a valid data";
              }
              return null;
            },
            controller: _aPaterno,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Set your last name',
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a valid data";
              }
              return null;
            },
            controller: _aMaterno,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Set your lastname',
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a valid data";
              }
              return null;
            },
            controller: _phoneNumber,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Set your phone number',
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a valid data";
              }
              return null;
            },
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Set your email',
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: ColorSetting.colorButton),
              onPressed: () async {
                if (widget.profileData == null) {
                  if (imagePicked) {
                    image = await saveImagePermanently(imageTempFile);
                  }
                  ProfileModel userData = ProfileModel(
                    name: _name.text,
                    aPaterno: _aPaterno.text,
                    aMaterno: _aMaterno.text,
                    phoneNumber: int.parse(_phoneNumber.text),
                    email: _email.text,
                    image: image != null ? image!.path : "",
                  );
                  _databaseHelper
                      .insertUserInfo(userData.toMap())
                      .then((value) {
                    if (value > 0) {
                      Navigator.pop(context);
                    } else {
                      print(value);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("La solicitud no se completo")));
                    }
                  });
                } else {
                  //Update
                  if (imagePicked) {
                    image = await saveImagePermanently(imageTempFile);
                  }
                  ProfileModel userData = ProfileModel(
                    id: 1,
                    name: _name.text,
                    aPaterno: _aPaterno.text,
                    aMaterno: _aMaterno.text,
                    phoneNumber: int.parse(_phoneNumber.text),
                    email: _email.text,
                    image: image != null ? image!.path : "",
                  );
                  _databaseHelper.updateUser(userData.toMap()).then((value) {
                    if (value > 0) {
                      Navigator.pop(context);
                    } else {
                      print(value);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("La solicitud no se completo")));
                    }
                  });
                }
              },
              child: widget.profileData != null
                  ? Text("Update Profile Info")
                  : Text('Save profile data'))
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: ColorSetting.colorPrimary,
      ),
      body: Card(
        margin: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              shrinkWrap: true,
              children: [SizedBox(height: 10), inputForm],
            )),
      ),
    );
  }

  Future<File> saveImagePermanently(XFile imageTemp) async {
    Directory? directory = await getExternalStorageDirectory();
    String filename = basename(imageTemp.path);
    String storePath = join(directory!.path, filename);
    await imageTemp.saveTo(storePath);
    return File(storePath);
  }
}
