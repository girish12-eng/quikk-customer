import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/addressmodel.dart';
import 'package:quikk_customer/models/category_model.dart';
import 'package:quikk_customer/models/coupon_model.dart';
import 'package:quikk_customer/repository/add_address_repo.dart';
import 'package:quikk_customer/repository/banner_repo.dart';
import 'package:quikk_customer/repository/coupon_repo.dart';
import 'package:quikk_customer/repository/market_repo.dart';
import 'package:quikk_customer/models/market_model.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as locationFetch;
import 'package:geocoding/geocoding.dart';
import 'package:quikk_customer/repository/user_repo.dart';
import 'package:quikk_customer/screens/market/search_market_screen.dart';
import 'package:quikk_customer/widgets/custom_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quikk_customer/models/banner_model.dart';

class HomeScreenController extends ChangeNotifier {
  late List<MarketModel> _shops;
  late List<CouponModel> _coupons;
  late List<CategoryModel> _categories;
  late List<AddressModel> _addresses;
  late SharedPreferences _preferences;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String? lat;
  String? lng;
  locationFetch.Location location = locationFetch.Location();
  bool loading = false;
  String? address;
  List<BannerModel> bannerList = [];

  Future<void> init() async {
    _shops = [];
    _coupons = [];
    _categories = [];
    _addresses = [];
    bannerList = [];
    getBanner();
    await getDefaultAddress();
  }

  void getBanner() async {
    bannerList = await getBannerRepo();
    notifyListeners();
  }

  void getShopsByCategory(String carId) async {
    loading = true;
    notifyListeners();
    _shops = [];
    _shops = await getMarketByCategoryRepo(carId, lat!, lng!);
    loading = false;
    notifyListeners();
  }

  void getCoupons() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    _coupons = [];
    _coupons = await getCouponsRepo(token);
    notifyListeners();
  }

  Future<void> getDefaultAddress() async {
    _preferences = await SharedPreferences.getInstance();
    var data = _preferences.getString('defaultAddress');
    var defLat = _preferences.getString('lat');
    var defLng = _preferences.getString('lng');
    print(data);
    print(data);
    print(data);
    if (data != null && defLat != null && defLng != null) {
      print('has default');
      address = data;
      lat = defLat;
      lng = defLng;
      getShop(defLat, defLng);
      getCategory();
      getCoupons();
      return;
    } else {
      print('has no default');
      await getCurrentLocation();
    }
  }

  void setDefaultAddress(
      String newAddress, String defLat, String defLng) async {
    _preferences = await SharedPreferences.getInstance();
    print(address);
    lat = defLat;
    lng = defLng;
    _preferences.setString('defaultAddress', newAddress);
    _preferences.setString('lat', defLat);
    _preferences.setString('lng', defLng);
    address = newAddress;
    notifyListeners();
  }

  void getCategory() async {
    _categories = await getAllCategoriesRepo();
    notifyListeners();
  }

  void getShop(String lat, String long) async {
    loading = true;
    notifyListeners();
    _shops = await getShopsRepo(lat, long) ?? [];
    loading = false;
    notifyListeners();
  }

  Future<void> getAddress() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString('token')!;
    _addresses = await getAddressRepo(token);
    notifyListeners();
  }

  void setLocationToDb(String lat, String lng) async {
    _preferences = await SharedPreferences.getInstance();
    String? token = _preferences.getString('token');
    await addUserLocationToDbRepo(token: token!, lat: lat, lng: lng);
  }

  Future<void> getCurrentLocation() async {
    loading = true;
    notifyListeners();
    var data = await location.getLocation();
    print(data.latitude);
    print(data.longitude);
    setLocationToDb(data.latitude.toString(), data.longitude.toString());
    try {
      var ll = await placemarkFromCoordinates(data.latitude!, data.longitude!);
      address = ll.map((e) => e.name).toString();
    } on Exception catch (e) {
      address = 'Unnamed Place';
    }
    print(address);
    lat = data.latitude.toString();
    lng = data.longitude.toString();
    getShop(
      data.latitude.toString(),
      data.longitude.toString(),
    );
    getCategory();
    getCoupons();
    setDefaultAddress(
      address!,
      data.latitude.toString(),
      data.longitude.toString(),
    );
    notifyListeners();
  }

  void onSearchLocation(BuildContext context) async {
    print('ddddddddddd');
    // const kGoogleApiKey = "AIzaSyBXhOliwczoeSYjOeZrFCzZBrrjBUTMg4Y";
    var p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      language: "en",
      context: context,
      mode: Mode.overlay,
      logo: Text(''),
      apiKey: Constant.KGoogleApiKey,
      // sessionToken: 'sessionToken',
      components: [
        Component(Component.country, "ind"),
      ],
      types: [],
      hint: "Search City",

      // startText: 's'
    );
    // print(p?.placeId);
    print(p?.description);
    address = p?.description!;
    Navigator.pop(context);
    // print(p?.terms);
    // print(p?.matchedSubstrings);
    // print(p?.distanceMeters);
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: Constant.KGoogleApiKey,
      // apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p!.placeId!);
    print(detail.result.geometry!.location.lat);
    print(detail.result.geometry!.location.lng);
    lat = detail.result.geometry!.location.lat.toString();
    lng = detail.result.geometry!.location.lng.toString();
    setDefaultAddress(p.description!, lat!, lng!);
    getShop(detail.result.geometry!.location.lat.toString(),
        detail.result.geometry!.location.lng.toString());
    notifyListeners();
  }

  void openBottomSheet(BuildContext context) {
    // notifyListeners();
    bool sheetLoading = false;
    bool first = false;
    print(first);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (_, setStateOfBottom) {
            if (!first) {
              setStateOfBottom(() {
                sheetLoading = true;
                getAddress().then((value) => setStateOfBottom(() {
                      first = true;
                      sheetLoading = false;
                    }));
              });
            }

            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 32),
              height: MediaQuery.of(context).size.height * .7,
              child: sheetLoading
                  ? CustomLoading()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search location',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                onSearchLocation(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black12, width: 2),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Color(Constant.KPrimaryColor),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Search for your location...',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                setStateOfBottom(() {
                                  sheetLoading = true;
                                  Future.delayed(Duration(seconds: 3)).then(
                                      (value) =>
                                          getCurrentLocation().then((value) {
                                            sheetLoading = false;
                                            Navigator.pop(context);
                                          }));
                                });
                              },
                              icon: Icon(
                                Icons.my_location,
                                color: Color(Constant.KPrimaryColor),
                              ),
                              label: Text(
                                'Use current location',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: Color(Constant.KPrimaryColor),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            _addresses.isEmpty
                                ? SizedBox()
                                : Text(
                                    'Saved Addresses',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                            SizedBox(
                              height: 16,
                            ),
                            _addresses.isEmpty
                                ? SizedBox()
                                : Container(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: _addresses.length,
                                      itemBuilder: (_, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            address =
                                                '${_addresses[index].completeAddress} ${_addresses[index].location!}';
                                            getShop(_addresses[index].lat!,
                                                _addresses[index].lng!);
                                            setDefaultAddress(
                                                '${_addresses[index].completeAddress} ${_addresses[index].location!}',
                                                _addresses[index].lat!,
                                                _addresses[index].lng!);
                                            notifyListeners();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, left: 16),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.home,
                                                  size: 18,
                                                  color: Colors.black38,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _addresses[index].type!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .7,
                                                      child: Text(
                                                        '${_addresses[index].completeAddress} ${_addresses[index].location}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              color: Colors
                                                                  .black38,
                                                            ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
            );
          },
        );
      },
    );
  }

  void goToSearchScreen(BuildContext context) {
    pushNewScreen(context,
        screen: SearchMarketScreen(
          lat: lat!,
          lng: lng!,
        ),
        withNavBar: false);
  }

  List<MarketModel> get getShops {
    return _shops;
  }

  List<CategoryModel> get getCategories {
    return _categories;
  }

  List<CouponModel> get getCoupon {
    return _coupons;
  }

  RefreshController get getRefreshController {
    return _refreshController;
  }
}
