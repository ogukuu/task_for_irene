import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/task.dart';
import '../../navigation/nav_route.dart';
import '../../utilits/format_date.dart';

class ActiveTaskCard extends StatelessWidget {
  const ActiveTaskCard({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    final double indent = MediaQuery.of(context).size.width / 12;
    final double padding = indent / 4;
    return GestureDetector(
      onTap: (() => Navigator.restorablePushNamed(
          context, NavRoute.activeTask + task.id)),
      child: Column(children: [
        Divider(
          thickness: 1,
          height: 0,
          endIndent: indent,
          indent: indent,
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: _Body(
            title: task.title,
            dueDate: task.dueDate,
            id: task.id,
          ),
        ),
        Divider(
          thickness: 1,
          height: 0,
          endIndent: indent,
          indent: indent,
        ),
      ]),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(
      {Key? key, required this.title, required this.dueDate, required this.id})
      : super(key: key);
  final String title;
  final DateTime dueDate;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _DueDate(dueDate: dueDate),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _Title(title: title),
              )
            ],
          ),
        ),
        _ActionButton(id: id)
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: 1.2,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _DueDate extends StatelessWidget {
  const _DueDate({Key? key, required this.dueDate}) : super(key: key);
  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, child: Text(getDDMMYYYY(dueDate)));
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Actions>(
        //icon: const Icon(Icons.arrow_drop_down),
        tooltip: "Action",
        elevation: 2,
        // Callback that sets the selected popup menu item.
        onSelected: (Actions item) {
          switch (item) {
            case Actions.delete:
              GlobalVar.appController.deleteTaskAtId(id);
              break;
            case Actions.proofGallery:
              _addProofGallery(id);
              break;
            case Actions.surrender:
              GlobalVar.appController.surrenderTaskAtId(id);
              break;
            case Actions.proofCamera:
              _addProofCamera(id);
              break;
            case Actions.edit:
              Navigator.restorablePushNamed(context, NavRoute.activeTask + id);
              break;
          }
        },
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Actions>>[
              PopupMenuItem<Actions>(
                value: Actions.proofGallery,
                child: _ActionProofGallery(),
              ),
              PopupMenuItem<Actions>(
                value: Actions.proofCamera,
                child: _ActionProofCamera(),
              ),
              PopupMenuItem<Actions>(
                value: Actions.edit,
                child: _ActionEdit(),
              ),
              PopupMenuItem<Actions>(
                value: Actions.surrender,
                child: _ActionSurrender(),
              ),
              PopupMenuItem<Actions>(
                value: Actions.delete,
                child: _ActionDelete(),
              )
            ]);
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
