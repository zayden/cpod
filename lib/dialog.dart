import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
saveDialog(BuildContext context, Directory? dir,
    List<FileSystemEntity> filesSystemEntity, String str) {
  final newFileController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        newFileController.text = 'file';
        return SimpleDialog(
          title: const Text('save file'),
          children: <Widget>[
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: newFileController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (newFileController.text.isNotEmpty) {
                            for (var i = 0; i < filesSystemEntity.length; i++) {
                              if (filesSystemEntity[i]
                                      .path
                                      .substring(dir!.path.length + 1) ==
                                  newFileController.text) {
                                Fluttertoast.showToast(
                                    msg:
                                        "file name is exit，please input new file name",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                            }
                            final file = File(dir!.path +
                                Platform.pathSeparator +
                                newFileController.text);
                            await file.writeAsString(str);
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "file name is empty，please input file name",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        },
                        child: const Text('YES')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('NO')),
                  ],
                ),
              ],
            ),
          ],
        );
      });
}

Future<dynamic> openDialog(BuildContext context, Directory? dir,
    List<FileSystemEntity> filesSystemEntity) {
  int chooseNum = 0;
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {

          return SimpleDialog(
            title: const Text('open file'),
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: GridView.builder(
                        itemCount: filesSystemEntity.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                chooseNum = index;
                              });
                              print(chooseNum);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color(0x00808080),
                                  width: 2,
                                ),
                                color: chooseNum == index
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withAlpha(180)
                                    : Colors.white,
                              ),
                              margin: const EdgeInsets.all(5),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.file_open,
                                        size: 50,
                                      ),
                                      Text(filesSystemEntity[index]
                                          .path
                                          .substring(dir!.path.length + 1)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            var str = await File(filesSystemEntity[chooseNum].path)
                                .readAsString();
                            if (context.mounted) {
                              Navigator.of(context).pop(str);
                            }
                          },
                          child: const Text('YES')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('NO')),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
      });
}
