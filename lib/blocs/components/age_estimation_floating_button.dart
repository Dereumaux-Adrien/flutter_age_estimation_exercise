import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../age_guessing_bloc/age_guessing.dart';

/// Floating button on AgeEstimationScreen
class AgeEstimationFloatingButton extends StatelessWidget {
  final TextEditingController textEditingController;

  /// Constructor
  const AgeEstimationFloatingButton(
      {super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeGuessingBloc, AgeGuessingState>(
        builder: (context, ageGuessingState) {
      return ageGuessingState is AgeGuessing
          ? const CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () {
                if (ageGuessingState is WaitingForInput &&
                    textEditingController.text.isNotEmpty) {
                  BlocProvider.of<AgeGuessingBloc>(context)
                      .add(RequestAge(name: textEditingController.text));
                } else if (ageGuessingState is AgeGuessed ||
                    ageGuessingState is AgeNotGuessed) {
                  BlocProvider.of<AgeGuessingBloc>(context).add(Reset());
                }
              },
              tooltip:
                  ageGuessingState is WaitingForInput ? 'Guess age' : 'Restart',
              child: ageGuessingState is WaitingForInput
                  ? const Icon(Icons.check)
                  : const Icon(Icons.restart_alt),
            );
    });
  }
}
