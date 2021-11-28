import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zendesk2/chat2/model/provider_model.dart';
import 'package:zendesk2/chat2/zendesk_chat2.dart';

class ChattingController extends ChangeNotifier {
  final Zendesk2Chat zendesk2chat = Zendesk2Chat.instance;

  final chatTextTED = TextEditingController();
  ProviderModel? providerModel;

  void init() async {
    Future.delayed(Duration(), () async {
      zendesk2chat.providersStream.listen((pModel) {
        providerModel = pModel;
        if (pModel.chatSessionStatus.toString() ==
            'CHAT_SESSION_STATUS.ENDED') {
          Fluttertoast.showToast(msg: 'Conversation ended');
        }
        notifyListeners();
      });
      notifyListeners();
    });
  }

  void disp() {
    zendesk2chat.dispose();
  }

  void attach(BuildContext context) async {
    print('ffffffffffffffffff');
    bool? isPhoto = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Row(
              children: [
                Icon(Icons.camera_alt),
                Text('Photo'),
              ],
            ),
            onTap: () => Navigator.of(context).pop(true),
          ),
          ListTile(
            title: Row(
              children: [
                // Icon(FontAwesomeIcons.file),
                Text('File'),
              ],
            ),
            onTap: () => Navigator.of(context).pop(false),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
    if (isPhoto == null) return;
    final compatibleExt = await zendesk2chat.getAttachmentExtensions();
    final result = isPhoto
        ? await ImagePicker().getImage(source: ImageSource.camera)
        : await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: compatibleExt,
          );
    if (result != null) {
      final file = result is FilePickerResult
          ? result.files.single
          : (result as PickedFile);

      final path = file is PlatformFile ? file.path : (file as PickedFile).path;

      if (path != null) {
        zendesk2chat.sendFile(path);
      }
    }
  }

  void send() async {
    print('lllllllllllllll');
    final text = chatTextTED.text;
    print('tttttttttttttttttttttttt');
    print(text);
    if (text.isNotEmpty) {
      await zendesk2chat.sendMessage(text);
      chatTextTED.clear();
      zendesk2chat.sendTyping(false);
      notifyListeners();
    }
  }
}
