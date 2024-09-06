import 'dart:convert';

import 'package:flutter_age_estimation_exercise/blocs/age_guessing_bloc/age_guessing.dart';
import 'package:flutter_age_estimation_exercise/models/searched_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

/// Our bloc making request to agify.io to guess ages from names
class AgeGuessingBloc extends Bloc<AgeGuessingEvent, AgeGuessingState> {
  /// Constructor
  AgeGuessingBloc() : super(WaitingForInput());

  @override
  Stream<AgeGuessingState> mapEventToState(AgeGuessingEvent event) async* {
    if (event is RequestAge) {
      yield* _mapRequestAgeToState(event);
    } else if (event is AgeReceived) {
      yield* _mapAgeReceivedToState(event);
    } else if (event is AgeNotReceived) {
      yield* _mapAgeNotReceivedToState(event);
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    }
  }

  Stream<AgeGuessingState> _mapRequestAgeToState(RequestAge event) async* {
    yield AgeGuessing(name: event.name);
    final response = await http
        .get(Uri.parse(
      // Added the replaceAll to avoid any issues with the spaces
      'https://api.agify.io?name=${event.name}',
    ))
        .catchError((error) {
      return http.Response("{}", 444);
    });

    print('RESPONSE: ${response.body}, STATUSCODE: ${response.statusCode}\n\n');

    if (response.statusCode == 200) {
      final searchedName = SearchedName.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      add(AgeReceived(searchedName: searchedName));
    } else {
      add(AgeNotReceived(limitReached: response.statusCode == 429));
    }
  }

  Stream<AgeGuessingState> _mapAgeReceivedToState(AgeReceived event) async* {
    yield AgeGuessed(searchedName: event.searchedName);
  }

  Stream<AgeGuessingState> _mapAgeNotReceivedToState(
      AgeNotReceived event) async* {
    yield AgeNotGuessed(
        errorMessage: event.limitReached
            ? "It seems we have used our allowed guesses for now, please try again later"
            : "I couldn't guess your age, please check your internet connection");
  }

  Stream<AgeGuessingState> _mapResetToState(Reset event) async* {
    yield WaitingForInput();
  }

  @override
  void onTransition(Transition<AgeGuessingEvent, AgeGuessingState> transition) {
    print('EVENT: ${transition.event}\n');
    print('NEW STATE: ${transition.nextState}\n');
    super.onTransition(transition);
  }
}
