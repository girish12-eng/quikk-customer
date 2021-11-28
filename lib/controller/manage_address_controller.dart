import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/addressmodel.dart';
import 'package:quikk_customer/repository/add_address_repo.dart';
import 'package:quikk_customer/widgets/custom_address_fields.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageAddressController extends ChangeNotifier {
  bool loading = false;
  late List<AddressModel> addresses;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  late SharedPreferences _preferences;
  TextEditingController completeAddressTED = TextEditingController();
  TextEditingController floorTED = TextEditingController();
  TextEditingController howToReachTED = TextEditingController();
  TextEditingController typeTED = TextEditingController();
  TextEditingController locationTED = TextEditingController();
  String? lat;
  String? lng;

  void init() {
    addresses = [];
    getAddress();
  }

  void onAddAddressButtonPressed(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Enter address details',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          controller: locationTED,
                          validator: (v) => validateFields(v!),
                          // onSaved:(v)=> controller.onSaveLocation(v!),
                          enableInteractiveSelection: false,
                          enableSuggestions: false,
                          onTap: () => onSearchLocation(context),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_on),
                              labelText: 'YOUR LOCATION *',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black38),
                              border: InputBorder.none),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomAddressFields(
                                controller: completeAddressTED,
                                validate: (v) => validateFields(v!),
                                save: onSaveCompleteAddress,
                                label: 'Complete Address *',
                                hint: 'House no./ Flat no. /Floor / Building'),
                            CustomAddressFields(
                                controller: floorTED,
                                save: onSaveFloor,
                                label: 'Floor(Optional)',
                                hint: 'e.g. Ground Floor(Optional)'),
                            CustomAddressFields(
                                controller: howToReachTED,
                                save: onSaveHowToReach,
                                label: 'How to reach (Optional)',
                                hint: 'Landmark / Entry gate / Street'),
                            CustomAddressFields(
                              controller: typeTED,
                              validate: (v) => validateFields(v!),
                              save: onSaveType,
                              label: 'Type *',
                              hint: 'Work / Home',
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              onPressed: () => onAddAddressPressed(context),
                              child: Text('Save Address'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  void getAddress() async {
    loading = true;
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    addresses = await getAddressRepo(token);
    loading = false;
    notifyListeners();
  }

  void deleteAddress(String id) async {
    loading = true;
    notifyListeners();
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    bool res = await deleteAddressRepo(token, id);
    if (res) {
      Fluttertoast.showToast(msg: 'Address delete success');
      getAddress();
    } else {
      Fluttertoast.showToast(msg: 'Address delete fails');
      loading = false;
      notifyListeners();
    }
  }

  void onAddAddressPressed(BuildContext context) async {
    _preferences = await SharedPreferences.getInstance();
    String? token = _preferences.getString('token');
    if (key.currentState!.validate()) {
      key.currentState!.save();
      var response = await addAddressRepo(
        token: token!,
        completeAddress: completeAddressTED.text,
        type: typeTED.text,
        location: locationTED.text,
        lat: lat!,
        lng: lng!,
      );
      if (response) {
        Fluttertoast.showToast(msg: 'Add address success');
        locationTED.text = '';
        completeAddressTED.text = '';
        floorTED.text = '';
        howToReachTED.text = '';
        typeTED.text = '';
        Navigator.pop(context);
        getAddress();
      } else {
        Fluttertoast.showToast(msg: 'Add address fails');
      }
    }
  }

  void onSearchLocation(BuildContext context) async {
    var p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: Constant.KGoogleApiKey,
      // sessionToken: 'sessionToken',
      components: [
        Component(Component.country, "ind"),
      ],
      types: [],
      hint: "Search City",
    );
    locationTED.text = p!.description!;
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: Constant.KGoogleApiKey,
      // apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    print(detail.result.geometry!.location.lat);
    print(detail.result.geometry!.location.lng);
    lat = detail.result.geometry!.location.lat.toString();
    lng = detail.result.geometry!.location.lng.toString();
    notifyListeners();
  }

  String? validateFields(String v) {
    if (v.isEmpty) return 'This field is required';
    return null;
  }

  void onSaveLocation(String v) {
    locationTED.text = v;
  }

  void onSaveCompleteAddress(String v) {
    completeAddressTED.text = v;
  }

  void onSaveFloor(String v) {
    floorTED.text = v;
  }

  void onSaveHowToReach(String v) {
    howToReachTED.text = v;
  }

  void onSaveType(String v) {
    typeTED.text = v;
  }
}
