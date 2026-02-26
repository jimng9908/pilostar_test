import 'package:equatable/equatable.dart';

class BusinessType extends Equatable {
  final String title;
  final String description;
  final String imagen;
  const BusinessType({
    required this.title,
    required this.description,
    required this.imagen,
  });

  @override
  List<Object?> get props => [title, imagen, description];
}
