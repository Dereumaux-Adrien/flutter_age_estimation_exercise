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
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    }
  }

  Stream<AgeGuessingState> _mapRequestAgeToState(RequestAge event) async* {
    yield AgeGuessing(name: event.name);
    final response = await http.get(Uri.parse(
        // 'https://jsonplaceholder.typicode.com/albums/1'
      'https://api.agify.io?name=${event.name.replaceAll(" ", "%20")}',
    ));

    print('RESPONSE: ${response.body}\n\n');

    if (response.statusCode == 200) {
      final searchedName = SearchedName.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      add(AgeReceived(searchedName: searchedName));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  Stream<AgeGuessingState> _mapAgeReceivedToState(AgeReceived event) async* {
    yield AgeGuessed(searchedName: event.searchedName);
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

  @override
  Future<void> close() {
    // _locationSubscription?.cancel();
    return super.close();
  }
}
