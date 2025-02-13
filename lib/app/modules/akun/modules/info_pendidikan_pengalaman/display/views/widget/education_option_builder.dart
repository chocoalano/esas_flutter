import 'package:flutter/material.dart';
import '../../../../../../../../constant.dart';
import '../../../../../../../models/users/formal_education.dart';
import '../../../../../../../models/users/informal_education.dart';
import '../../../../../../../models/users/work_experience.dart';
import 'detail_card.dart';

class EducationOptionBuilder {
  static Widget buildSection({
    required String title,
    VoidCallback? onTitleTap,
    required List<Widget> options,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: title, onTap: onTitleTap),
        const SizedBox(height: 10),
        ...options,
        const SizedBox(height: 20),
      ],
    );
  }

  static Widget _buildSectionTitle(
      {required String title, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          if (onTap != null)
            IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.edit_note, color: primaryColor),
            ),
        ],
      ),
    );
  }

  static List<Widget> buildFormalEducationOptions(
    List<FormalEducation> educationList,
    String noDataMessage,
  ) {
    return educationList.isNotEmpty
        ? educationList.asMap().entries.map((entry) {
            int index = entry.key;
            FormalEducation education = entry.value;
            return DetailCard.buildFormalEducationCard(education, index);
          }).toList()
        : [buildNoDataOption(noDataMessage)];
  }

  static List<Widget> buildInformalEducationOptions(
    List<InformalEducation> educationList,
    String noDataMessage,
  ) {
    return educationList.isNotEmpty
        ? educationList.asMap().entries.map((entry) {
            int index = entry.key;
            InformalEducation education = entry.value;
            return DetailCard.buildInformalEducationCard(education, index);
          }).toList()
        : [buildNoDataOption(noDataMessage)];
  }

  static List<Widget> buildWorkExperienceOptions(
    List<WorkExperience> experienceList,
    String noDataMessage,
  ) {
    return experienceList.isNotEmpty
        ? experienceList.asMap().entries.map((entry) {
            int index = entry.key;
            WorkExperience education = entry.value;
            return DetailCard.buildWorkExperienceCard(education, index);
          }).toList()
        : [buildNoDataOption(noDataMessage)];
  }

  static Widget buildNoDataOption(String message) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: const Icon(Icons.info_outline, color: Colors.black54),
        title: Text(message),
      ),
    );
  }
}
