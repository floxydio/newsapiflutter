import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdits extends StatefulWidget {
  @override
  _ProfileEditsState createState() => _ProfileEditsState();
}

class _ProfileEditsState extends State<ProfileEdits> {
  File _image;
  final picker = ImagePicker();


  Future _getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  _image == null
                      ? RawMaterialButton(
                          onPressed: () {},
                          elevation: 1.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 35.0,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        )
                      : Image.file(
                          _image,
                        ),
                  TextButton(
                      onPressed: () {
                        _getImage();
                      },
                      child: Text('Add From Gallery')),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Flexible(
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'First Name...'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Flexible(
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Last Name...'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton<String>(
                      hint: Text('Select Your Gender'),
                      items: <String>['Laki - Laki', 'Perempuan']
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Your Address...'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Flexible(
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Your Password..'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Retype your Password'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        Get.defaultDialog(
                          middleText: 'Data kamu disimpan ya...',
                          title: 'Hai',
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
