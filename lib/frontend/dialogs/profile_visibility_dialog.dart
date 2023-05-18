import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/enum/user_profile_visibility_enum.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

class ProfileVisibilityDialog extends StatefulWidget {
  const ProfileVisibilityDialog({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileVisibilityDialogState();
}

class _ProfileVisibilityDialogState extends State<ProfileVisibilityDialog> {
  String? visibility;

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();
    if (visibility == null) {
      setState(() {
        visibility = profileViewModel.user!.visibility;
      });
    }

    return Dialog(
      child: SizedBox(
        height: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                children: UserProfileVisibilityEnum.values
                    .map((value) => ListTile(
                          title: Text(snakeCaseToSentenceCase(value)),
                          leading: Radio<String>(
                            value: value,
                            groupValue: visibility,
                            onChanged: (String? value) {
                              setState(() {
                                visibility = value;
                              });
                            },
                          ),
                        ))
                    .toList()),
            ElevatedButton(
                onPressed: () async {
                  await profileViewModel.updateProfileVisibility(visibility);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
