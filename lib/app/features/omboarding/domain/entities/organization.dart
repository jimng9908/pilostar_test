import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  const Organization({
    required this.id,
    required this.name,
    required this.nif,
    required this.isActive,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final String? nif;
  final bool? isActive;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        name,
        nif,
        isActive,
        createdAt,
      ];
}
