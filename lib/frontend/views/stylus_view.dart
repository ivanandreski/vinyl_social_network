import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/stylus_view_model.dart';
import 'package:vinyl_social_network/frontend/components/stylus_card.dart';
import 'package:vinyl_social_network/frontend/dialogs/create_stylus_dialog.dart';

class StylusView extends StatefulWidget {
  const StylusView({super.key});

  @override
  State<StatefulWidget> createState() => _StylusViewState();
}

class _StylusViewState extends State<StylusView> {
  @override
  Widget build(BuildContext context) {
    final stylusViewModel = context.watch<StylusViewModel>();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const CreateStylusDialog())
                .then((value) => {stylusViewModel.createStylus(value)});
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(title: const Text("Styluses")),
        body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CustomScrollView(
              slivers: <Widget>[
                const SliverToBoxAdapter(
                  child: Text(
                    'Active',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(stylusViewModel
                      .activeStyluses
                      .map((s) => StylusCard(stylus: s))
                      .toList()),
                ),
                const SliverToBoxAdapter(
                    child: Column(
                  children: [
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 8)
                  ],
                )),
                const SliverToBoxAdapter(
                  child: Text(
                    'Retired',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(stylusViewModel
                      .retiredStyluses
                      .map((s) => StylusCard(stylus: s))
                      .toList()),
                ),
              ],
            )));
  }
}
