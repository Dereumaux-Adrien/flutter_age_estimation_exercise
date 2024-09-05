import 'package:flutter/material.dart';
import 'package:flutter_age_estimation_exercise/blocs/age_guessing_bloc/age_guessing.dart';
import 'package:flutter_age_estimation_exercise/blocs/components/age_estimation_body.dart';
import 'package:flutter_age_estimation_exercise/blocs/components/age_estimation_floating_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// View of the GeoMap
class AgeEstimationScreen extends StatelessWidget {
  /// Route to bind to this page
  static const String route = '/map';

  AgeEstimationScreen({super.key});

  final textEditingController = TextEditingController(
    text: "",
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AgeGuessingBloc>(
      create: (BuildContext context) => AgeGuessingBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Let's play a game"),
        ),
        body: AgeEstimationBody(
          textEditingController: textEditingController,
        ),
        floatingActionButton: AgeEstimationFloatingButton(
            textEditingController:
                textEditingController), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
