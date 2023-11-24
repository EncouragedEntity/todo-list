import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoLoadAllItemsEvent extends TodoEvent {}
