import 'package:flutter/material.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../common/widgets/custombutton.dart';
import '../constant/Theme_constant.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void showCustomDialog(BuildContext context, String text, IconData icon) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: COLOR_ACCENT,
                radius: 25,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: "Ok",
                 onTap: ()=>    Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// void showSnackBar(BuildContext context, String text) {
//   final snackBar = SnackBar(
//     content: Container(
//       padding: EdgeInsets.symmetric(
//         vertical: MediaQuery.of(context).size.height * 0.02,
//         horizontal: MediaQuery.of(context).size.width * 0.04,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.grey[800],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.info,
//             color: Colors.white,
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//     duration: const Duration(seconds: 3),
//     behavior: SnackBarBehavior.floating,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//     action: SnackBarAction(
//       label: 'OK',
//       textColor: Colors.white,
//       onPressed: () {
//         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//         // Handle action button tap
//       },
//     ),
//   );

//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

Future<List<File>> pickImages() async {
  List<File> images = [];

  try {
    var file = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (file != null && file.files.isNotEmpty) {
      for (int i = 0; i < file.files.length; i++) {
        images.add(File(file.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
