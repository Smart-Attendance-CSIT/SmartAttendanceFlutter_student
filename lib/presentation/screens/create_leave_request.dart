import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../config/constants/app_theme.dart';
import '../../data/api_interface.dart';

class CreateLeaveRequest extends StatefulWidget {
  final String groupCode;
  const CreateLeaveRequest({super.key, required this.groupCode});

  @override
  State<CreateLeaveRequest> createState() => _CreateLeaveRequestState();
}

class _CreateLeaveRequestState extends State<CreateLeaveRequest> {
  final _formKey = GlobalKey<FormState>();
//text editing controllers
  final dateController = TextEditingController();

  final reasonController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          const Text(
                            "Select Date:  ",
                            style: labelStyle,
                            textAlign: TextAlign.left,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());

                                DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().toUtc(),
                                    firstDate: DateTime(1900).toUtc(),
                                    lastDate: DateTime(2100).toUtc());
                                // DateTime utcDatetime = date!.toUtc();

                                dateController.text =
                                    '${date!.toIso8601String()}Z';
                              },
                              controller: dateController,
                              decoration: const InputDecoration(
                                hintText: 'Select Date',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                              ),
                            ),
                          ),
                          const Text(
                            "Write leave request message: ",
                            style: labelStyle,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          //userfield
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              minLines: 3,
                              maxLines: 4,
                              controller: reasonController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please write valid reason';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Write Reason',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 50,
                            width: 500,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColor),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    String uploadMessage = await requestLeave(
                                        dateController.text,
                                        reasonController.text,
                                        widget.groupCode);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(uploadMessage)));
                                    Navigator.pop(context);
                                    // jumpToOptionScreen(context);
                                  }
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),

                          const SizedBox(height: 50),
                        ]),
                  ),
                ),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Future<String> requestLeave(
      String dateTime, String message, String groupCode) async {
    String uploadStatus = "";
    ApiInterface apiInterface = ApiInterface();
    setState(() {
      isLoading = true;
    });
    try {
      uploadStatus = await apiInterface.leaveRequest(
          date: dateTime, message: message, groupId: groupCode);
    } catch (e) {}
    return uploadStatus;
  }
}
