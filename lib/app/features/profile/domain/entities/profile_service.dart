import 'package:equatable/equatable.dart';

class ProfileService extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isSelected;
  final String iconAsset; // or IconData logic

  const ProfileService({
    required this.id,
    required this.title,
    required this.description,
    required this.isSelected,
    this.iconAsset = '',
  });

  @override
  List<Object?> get props => [id, title, description, isSelected, iconAsset];

  ProfileService copyWith({
    String? id,
    String? title,
    String? description,
    bool? isSelected,
    String? iconAsset,
  }) {
    return ProfileService(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
      iconAsset: iconAsset ?? this.iconAsset,
    );
  }
}
