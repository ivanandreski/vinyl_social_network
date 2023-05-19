import 'package:flutter/material.dart';

class CreateStylusDialog extends StatefulWidget {
  const CreateStylusDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreateStylusDialogState();
}

class _CreateStylusDialogState extends State<CreateStylusDialog> {
  String _name = "";
  String _error = "";

  _handleSubmit() async {
    if(_name.isEmpty) {
      setState(() {
        _error = "Name cannot be empty";
      });
    }

    Navigator.pop(context, _name);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Create Stylus",
                  style: TextStyle(fontSize: 24),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 5),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                        if(val.isNotEmpty) {
                          _error = "";
                        }
                      });
                    },
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: _handleSubmit,
                              child: Text("Submit"),
                            )),
                        Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            )),
                        // todo: error placeholder
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
