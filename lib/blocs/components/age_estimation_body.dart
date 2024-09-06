import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../age_guessing_bloc/age_guessing.dart';

/// Widget in the body of the AgeEstimationScreen
class AgeEstimationBody extends StatelessWidget {
  final TextEditingController textEditingController;

  /// Constructor
  const AgeEstimationBody({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeGuessingBloc, AgeGuessingState>(
        builder: (context, ageGuessingState) {
      return Center(
          child: ageGuessingState is WaitingForInput
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'I can guess your age from your name!',
                    ),
                    TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        isDense: true,
                      ),
                      maxLength: 30,
                      maxLines: 1,
                      maxLengthEnforcement:
                          MaxLengthEnforcement.truncateAfterCompositionEnds,
                      readOnly: false,
                      enabled: true,
                    ),
                  ],
                )
              : ageGuessingState is AgeGuessed
                  ? Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: Text(
                        '${ageGuessingState.searchedName.name} your age is ${ageGuessingState.searchedName.age}',
                      ),
                    )
                  : ageGuessingState is AgeNotGuessed
                      ? Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          child: Text(
                            ageGuessingState.errorMessage,
                          ),
                        )
                      : const CircularProgressIndicator());
    });
  }
}
