import '../../models/searched_name.dart';

/// Abstract of AgeGuessingEvent
abstract class AgeGuessingEvent {
  /// Constructor
  const AgeGuessingEvent();
}

/// Making a request to guess an age to Agify.io
class RequestAge extends AgeGuessingEvent {
  /// Requested name to agify
  final String name;

  /// Constructor
  const RequestAge({required this.name});

  @override
  String toString() => 'RequestAge { name: $name }';
}

/// Agify.io answered the request
class AgeReceived extends AgeGuessingEvent {
  /// Received result from agify
  final SearchedName searchedName;

  /// Constructor
  const AgeReceived({required this.searchedName});

  @override
  String toString() => 'AgeReceived { searchedName: $searchedName }';
}

/// Reset to be able to guess another name
class Reset extends AgeGuessingEvent {
  /// Constructor
  const Reset();

  @override
  String toString() => 'Reset';
}
