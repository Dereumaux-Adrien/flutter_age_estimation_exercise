import 'package:flutter_age_estimation_exercise/models/searched_name.dart';

/// Abstract state for the AgeGuessing bloc
abstract class AgeGuessingState {
  /// Constructor
  const AgeGuessingState();
}

/// Starting State
class WaitingForInput extends AgeGuessingState {
  @override
  String toString() => 'AgeGuessingWaiting ';
}

/// Request is being made to agify.io
class AgeGuessing extends AgeGuessingState {
  /// Requested name to agify
  final String name;

  /// Constructor
  const AgeGuessing({required this.name});

  @override
  String toString() => 'AgeGuessing { name: $name }';
}

/// Request has been received from agify.io
class AgeGuessed extends AgeGuessingState {
  /// Received result from agify
  final SearchedName searchedName;

  /// Constructor
  const AgeGuessed({required this.searchedName});

  @override
  String toString() => 'AgeGuessed { searchedName: $searchedName }';
}

/// Request did not work
class AgeNotGuessed extends AgeGuessingState {
  /// Fully written error message to show user
  final String errorMessage;

  /// Constructor
  const AgeNotGuessed({required this.errorMessage});

  @override
  String toString() => 'AgeNotGuessed { errorMessage: $errorMessage }';
}
