import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomImageFormField extends StatefulWidget {
  final void Function(Uint8List) onChanged;
  final String title;
  final Uint8List? initialValue;

  const CustomImageFormField({
    Key? key,
    required this.onChanged,
    required this.title,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CustomImageFormField> createState() => _CustomImageFormFieldState();
}

class _CustomImageFormFieldState extends State<CustomImageFormField> {
  Uint8List? _image;

  void getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      var filePath = result.files.single.path;
      if (filePath != null) {
        File file = File(filePath);
        _image = await file.readAsBytes();
        if (_image != null) {
          widget.onChanged(_image!);
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _image = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Visibility(
            visible: _image != null,
            child: SizedBox(
              width: size.width,
              height: size.width * 0.6,
              child: _image != null
                  ? Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: getImage,
                            icon: const Icon(
                              Icons.replay_outlined,
                              size: 30,
                              color: Colors.orange,
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(),
            ),
          ),
          Visibility(
            visible: _image == null,
            child: SizedBox(
              width: size.width,
              height: size.width * 0.15,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                onPressed: getImage,
                child: const Text(
                  'Pick image',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
