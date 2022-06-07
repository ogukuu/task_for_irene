import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, required this.id, this.onEdit = true})
      : super(key: key);
  final bool onEdit;
  final String id;
  @override
  Widget build(BuildContext context) {
    var list = <PopupMenuEntry<Actions>>[];
    list.add(const PopupMenuItem<Actions>(
      value: Actions.proofGallery,
      child: _ActionProofGallery(),
    ));
    list.add(const PopupMenuItem<Actions>(
      value: Actions.proofCamera,
      child: _ActionProofCamera(),
    ));
    if (onEdit) {
      list.add(const PopupMenuItem<Actions>(
        value: Actions.edit,
        child: _ActionEdit(),
      ));
    }
    list.add(const PopupMenuItem<Actions>(
      value: Actions.surrender,
      child: _ActionSurrender(),
    ));
    list.add(const PopupMenuItem<Actions>(
      value: Actions.delete,
      child: _ActionDelete(),
    ));

    return PopupMenuButton<Actions>(
        tooltip: AppLocalizations.of(context)!.actionButtonTooltip,
        elevation: 2,
        onSelected: (Actions item) {
          switch (item) {
            case Actions.delete:
              GlobalVar.appController.deleteTaskAtId(id);
              if (!onEdit) Navigator.pop(context);
              break;
            case Actions.proofGallery:
              if (!onEdit) Navigator.pop(context);
              _addProofGallery(id);
              break;
            case Actions.surrender:
              GlobalVar.appController.surrenderTaskAtId(id);
              if (!onEdit) Navigator.pop(context);
              break;
            case Actions.proofCamera:
              if (!onEdit) Navigator.pop(context);
              _addProofCamera(id);
              break;
            case Actions.edit:
              Navigator.restorablePushNamed(context, NavRoute.activeTask + id);
              break;
          }
        },
        itemBuilder: (BuildContext context) => list);
  }
}

class _ActionProofCamera extends StatelessWidget {
  const _ActionProofCamera({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.add_a_photo_outlined),
        const VerticalDivider(),
        Text(AppLocalizations.of(context)!
            .activeTaskCardActionProvideProofCamera),
      ],
    );
  }
}

class _ActionProofGallery extends StatelessWidget {
  const _ActionProofGallery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.photo_library_outlined),
        const VerticalDivider(),
        Text(AppLocalizations.of(context)!
            .activeTaskCardActionProvideProofGallery),
      ],
    );
  }
}

class _ActionDelete extends StatelessWidget {
  const _ActionDelete({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.delete_forever_outlined),
        const VerticalDivider(),
        Text(AppLocalizations.of(context)!.activeTaskCardActionDelete),
      ],
    );
  }
}

class _ActionSurrender extends StatelessWidget {
  const _ActionSurrender({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.sentiment_dissatisfied),
        const VerticalDivider(),
        Text(AppLocalizations.of(context)!.activeTaskCardActionSurrender),
      ],
    );
  }
}

class _ActionEdit extends StatelessWidget {
  const _ActionEdit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.edit_outlined),
        const VerticalDivider(),
        Text(AppLocalizations.of(context)!.activeTaskCardActionEdit),
      ],
    );
  }
}

enum Actions { delete, surrender, proofGallery, proofCamera, edit }

void _addProofGallery(String id) async {
  if (!Platform.isAndroid) return null;
  final ImagePicker picker = ImagePicker();
  XFile? pickImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickImage != null) {
    Uint8List image = await pickImage.readAsBytes();
    GlobalVar.appController.proofTask(id, image);
  }
}

void _addProofCamera(String id) async {
  if (!Platform.isAndroid) return null;
  final ImagePicker picker = ImagePicker();
  XFile? pickImage = await picker.pickImage(source: ImageSource.camera);
  if (pickImage != null) {
    Uint8List image = await pickImage.readAsBytes();
    GlobalVar.appController.proofTask(id, image);
  }
}
