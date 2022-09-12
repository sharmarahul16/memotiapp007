import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
// import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UiData {
  //app name
  static const String appName = "Memoticom";
  static const String user_id = "user_id";
  static const String checkingdb = "checkingdb";
  static const String email = "email";
  static const String name = "name";
  static const String token = "token";
  static const String picture = "picture";
  static const String facebook_token = "facebook_token";
  static const String facebook_user_id = "facebook_user_id";
  static const String instagram_token = "instagram_token";
  static const String instagram_user_id = "instagram_user_id";
  static const String address = "address";

  static const String google_auth_token = "google_auth_token";
  //route path
  static const String homeRoute = "/home";
  static const String termsConditionsRoute = "/termsAndConditions";
  static const String privacyPolicyRoute = "/privacyPolicy";
  static const String loginRoute = "/LoginPage";
  static const String orderDetailRoute = "/OrderDetailPage";
  static const String signUpRoute = "/signUp";
  static const String productRoute = "/product";
  static const String previewRoute = "/preview";
  static const String cartRoute = "/cart";
  static const String orderRoute = "/orders";
  static const String addImageRoute = "/addImages";
  static const String configureRoute = "/configure";
  static const String paymentRoute = "/payment";
  static const String shippingSummaryRoute = "/shippingSummary";
  static const String accountRoute = "/myAccount";
  static const String checkListRoute = "/checkList";

  static const String selctDimensionRoute = "/selectDimensions";
  static const String selectColorRoute = "/selectColors";
  static const String selectBindingOptionsRoute = "/selectBinding";
  static const String cropRotateImageRoute = "/cropImage";

//images
  static const String imageDir = "assets/images";
  static const String dummyUser = "$imageDir/dummy_user.png";
  static const String profileImage = "$imageDir/profile.jpg";
  static const String blankImage = "$imageDir/blank.jpg";
  static const String dashboardImage = "$imageDir/dashboard.jpg";
  static const String loginImage = "$imageDir/login.jpg";
  static const String paymentImage = "$imageDir/payment.jpg";
  static const String settingsImage = "$imageDir/setting.jpeg";
  static const String shoppingImage = "$imageDir/shopping.jpeg";
  static const String timelineImage = "$imageDir/timeline.jpeg";
  static const String verifyImage = "$imageDir/verification.jpg";
  static const String lorem_ipsum = "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with:Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout. A practice not without controversy, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.";
  static const MaterialColor ui_kit_color = Colors.grey;

//colors
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }

  static List<String> dummyimages = [
    profileImage,
    blankImage,
    dashboardImage,
    loginImage,
    paymentImage,
    settingsImage,
    shoppingImage,
    timelineImage,
    verifyImage,
    dashboardImage
  ];
//fonts

}

class Font {
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";
}

class StaticLists {
  static final List<String> minPhotosCount = [
    "20-100",
    "20-100",
    "1",
    "1-300",
    "12"
  ];
  static final List<String> category = <String>[
    "Economy Photo Book",
    'Photo Book',
    'Calendar',
    'Canvas',
    'Poster',

  ];
  static final List<String> subcatEconomyPhotoBook = <String>[
    'Coil binding: 20 – 96 strán',
    'Spin binding: 20 – 36 strán',
  ];
  static final List<String> subcatPhotoBook = <String>[
    'Hard Bookbinding',
    'Free bookBinding',
  ];
  static final List<String> subcatCanvas = <String>[
    'Printing over the edge',
    'Printing to the edge',
  ];
  static final List<String> subcatPoster = <String>[
    'Little Prints Pack',
    'Flush Mount Print',
    'Standard Photo print',
    'Art Print',
  ];
  static final List<String> subcatCalendar = <String>[
    'Poster Calendar',
    'Wall Calendar',
    'Little Moments calendar',
    'Desk Calendar',
  ];

  static final List<String> subcatGift = <String>[
    'Crystal plaque',
    'Ice',
    'Littel Prints Stand',
    'Wood Plague',
  ];
  static final List<String> imagesHome = <String>[
    'assets/images/economy_photobook.jpg',
    'assets/images/photobook.jpg',
    'assets/images/calendar.jpg',
    'assets/images/canvas.jpg',
    'assets/images/poster.jpg',
  ];
  static final List<String> imagesBook = <String>[
    'assets/images/photo-bok-sub-1.jpg',
    'assets/images/photo-bok-sub-2.jpg',
    'assets/images/photo-bok-sub-3.jpg',
    'assets/images/photo-bok-sub-4.jpg',
    'assets/images/photo-bok-sub-5.jpg',
    'assets/images/photo-bok-sub-6.jpg',
    'assets/images/photo-bok-sub-7.jpg',
  ];
  static final List<String> imagesCanvas = <String>[
    'assets/images/wall-art-sub-1.jpg',
    'assets/images/wall-art-sub-2.jpg',
    'assets/images/wall-art-sub-3.jpg',
    'assets/images/wall-art-sub-4.jpg',
  ];
  static final List<String> imagesPoster = <String>[
    'assets/images/print-sub-1.jpg',
    'assets/images/print-sub-2.jpg',
    'assets/images/print-sub-3.jpg',
    'assets/images/print-sub-4.jpg',
  ];
  static final List<String> imagesCalendar = <String>[
    'assets/images/calender-sub-1.jpg',
    'assets/images/calender-sub-2.jpg',
    'assets/images/calender-sub-3.jpg',
    'assets/images/calender-sub-4.jpg',
  ];

  static final List<String> imagesGift = <String>[
    'assets/images/photo-gift-sub-1.jpg',
    'assets/images/photo-gift-sub-2.jpg',
    'assets/images/photo-gift-sub-3.jpg',
    'assets/images/photo-gift-sub-4.jpg',
  ];
}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
class MyColors {
  static final HexColor primaryColor = HexColor("53C9CF");
  static final HexColor primaryColoralredayHaveAccount = HexColor("26e8ef");
  static final HexColor textColor = HexColor("363636");
  static final HexColor detail_bg_ecolour = HexColor("cdced3");
  static final HexColor calender_detail_box_bg_ecolour = HexColor("F0F0F2");
}
const String prefSelectedLanguageCode = "SelectedLanguageCode";
Future<String> getStringLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  /*String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";*/
  return _prefs.getString(prefSelectedLanguageCode) ?? "en";
}


class   SizeConfig {
   late MediaQueryData _mediaQueryData;
   late double screenWidth;
   late double screenHeight;
   late double blockSizeHorizontal;
   late double blockSizeVertical;
  static double accountImagePlacementHeight =0;
  static double fontForAccountPage14to11 = 14;
  static double   fontForAccountPage22to16 = 22;
  static double fontForAccountPage18to14 = 18;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    if (screenHeight <= 600) {
      accountImagePlacementHeight = 0;
      fontForAccountPage14to11 = 11;
      fontForAccountPage22to16 = 16;
      fontForAccountPage18to14 = 14;
    } else if (screenHeight <= 700) {
      accountImagePlacementHeight = _mediaQueryData.size.height * 0.05;
      fontForAccountPage14to11 = 11;
    } else if (screenHeight <= 800)
      accountImagePlacementHeight = _mediaQueryData.size.height * 0.06;
    else if (screenHeight <= 900)
      accountImagePlacementHeight = _mediaQueryData.size.height * 0.077;
    else if (screenHeight <= 1000)
      accountImagePlacementHeight = _mediaQueryData.size.height * 0.08;
    else if (screenHeight <= 1200)
      accountImagePlacementHeight = _mediaQueryData.size.height * 0.11;
    else if (screenHeight <= 1400)
      accountImagePlacementHeight = _mediaQueryData.size.height * 0.15;
  }
}


class DynamicBoxForBookSize extends StatefulWidget {
  final String price;
  final double width;
  final double height;
  final VoidCallback onPressed;

  DynamicBoxForBookSize({required this.price, required this.width, required this.height, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return DynamicBoxForBookSizeState();
  }
}

class DynamicBoxForBookSizeState extends State<DynamicBoxForBookSize> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
            elevation: 5,
            child: Container(
              alignment: Alignment.center,
              width: widget.width,
              height: widget.height,
              color: HexColor("D5D6D8"),
            )),
        Text(
          widget.price,
          style: TextStyle(
              color: MyColors.textColor,
              fontSize: SizeConfig.fontForAccountPage14to11,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
class AlbumPaging {
  List<Album> data;
  Pagination pagination;

  AlbumPaging.fromJson(Map json)
      : data = (json['data'] as List)
      .map((album) => Album.fromJson(album))
      .toList(),
        pagination = Pagination.fromJson(json['paging']);
}
class Pagination {
  final Cursors cursor;
  final String next;

  Pagination(
      this.cursor,
      this.next,
      );

  Pagination.fromJson(Map json)
      : cursor = Cursors.fromJson(json['cursors']),
        next = json['next'];
}
class Album {
  final String id;
  final int count;
  final String name;
  final String coverPhoto;

  Album(
      this.id,
      this.count,
      this.name,
      this.coverPhoto,
      );

  Album.fromJson(Map json)
      : id = json['id'],
        count = json['count'],
        name = json['name'],
        coverPhoto = json['cover_photo']['source'];
}

class Cursors {
  final String before;
  final String after;

  Cursors(
      this.before,
      this.after,
      );

  Cursors.fromJson(Map json)
      : before = json['before'],
        after = json['after'];
}

class Photo {
  /// The Facebook ID of the photo
  final String id;

  /// The width of the photo in pixels
  final int width;

  // The height of the photo in pixels
  final int height;

  // The name of the photo
  final String name;

  // The source of the photo
  final String source;

  Photo(
      this.id,
      this.width,
      this.height,
      this.name,
      this.source,
      );

  Photo.fromJson(Map json)
      : id = json['id'],
        width = json['width'],
        height = json['height'],
        name = json['name'],
        source = json['source'];
  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Photo && runtimeType == other.runtimeType && id == other.id;
}

class PhotoPaging {
  List<Photo> data;
  Pagination pagination;

  PhotoPaging.fromJson(Map json)
      : data = (json['data'] as List)
      .map((photo) => Photo.fromJson(photo))
      .toList(),
        pagination = Pagination.fromJson(json['paging']);
}
class GraphApiException implements Exception {
  String error;

  GraphApiException(this.error);

  @override
  String toString() {
    return error;

  }
}
class Instagram {
  /// [clientID], [appSecret], [redirectUri] from your facebook developer basic display panel.
  /// [scope] choose what kind of data you're wishing to get.
  /// [responseType] I recommend only 'code', I try on DEV MODE with token, it wasn't working.
  /// [url] simply the url used to communicate with Instagram API at the beginning.
  static const String clientID = "582357346469369";
  static const String appSecret = "e4fd2b530dd397e5cfddcf6ecfe0fd78";
  static const String redirectUri = "https://memoti.herokuapp.com/auth/";
  static const String scope = 'user_profile,user_media';/*"user_profile";*/
  static const String responseType = 'code';
  static const String url = 'https://api.instagram.com/oauth/authorize?client_id=${clientID}&redirect_uri=${redirectUri}&scope=${scope}&response_type=${responseType}';
  static  String authorizationCode = '';
  static  var accessToken ;
  static  var userID ;
  static  var instaProfile ;
  late List<InstaMedia> medias ;

  /// Presets your required fields on each call api.
  /// Please refers to https://developers.facebook.com/docs/instagram-basic-display-api/reference .
  List<String> userFields = ['id', 'username'];
  List<String> mediasListFields = ['id', 'caption','media_url','media_type','username', 'timestamp'];
  List<String> mediaFields = [
    'id',
    'media_type',
    'media_url',
    'username',
    'timestamp'
  ];

  void getAuthorizationCode(String url) {
    /// Parsing the code from string url.

    authorizationCode =
        url.replaceAll('${redirectUri}?code=', '').replaceAll('#_', '');
    print("instaProfileauthorizationCode");
    print(authorizationCode);
  }
  Future<bool> getTokenAndUserID() async {
    /// Request token.
    /// Set token.
    /// Returning status request as bool.
    final http.Response response =
    await http.post(Uri.parse("https://api.instagram.com/oauth/access_token"), body: {
      "client_id": clientID,
      "redirect_uri": redirectUri,
      "client_secret": appSecret,
      "code": authorizationCode,
      "grant_type": "authorization_code"
    });

    accessToken = json.decode(response.body)['access_token'];
    userID = json.decode(response.body)['user_id'].toString();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(UiData.instagram_token, accessToken);
    prefs.setString(UiData.instagram_user_id, userID);
    String userId = prefs.getString(UiData.user_id) != null?prefs.getString(UiData.user_id):"";
    print("user_id - ");

    print("instaProfileaccessToken");
    print(accessToken);
    print("instaProfileuserid");
    print(userID);
    return (accessToken != null && userID != null) ? true : false;
  }
  Future<bool> getUserProfile() async {
    /// Parse according fieldsList.
    /// Request instagram user profile.
    /// Set profile.
    /// Returning status request as bool.
    final String fields = userFields.join(',');
    final http.Response responseNode = await http.get(Uri.parse('https://graph.instagram.com/${userID}?fields=${fields}&access_token=${accessToken}'));
    print("instaProfile");
    print(responseNode.body);
    instaProfile = {
      'id': json.decode(responseNode.body)['id'].toString(),
      'username': json.decode(responseNode.body)['username'],
    };

    return (instaProfile != null) ? true : false;
  }
  Future<List<InstaMedia>> getAllMedias() async {
    /// Parse according fieldsList.
    /// Request instagram user medias list.
    /// Request for each media id the details.
    /// Set all medias as list Object.
    /// Returning the List<InstaMedia>.


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString(UiData.instagram_user_id);
    String token = prefs.getString(UiData.instagram_token);
    final String fields = mediasListFields.join(',');
    final http.Response responseMedia = await http.get(
        Uri.parse('https://graph.instagram.com/${user_id}/media?fields=${fields}&access_token=${token}'));
    Map<String, dynamic> mediasList = json.decode(responseMedia.body);
    for(int i = 0;i<mediasList.length;i++){
      print("media item");
      print(mediasList.length);
      print(mediasList.values);
    }
    medias = [];
    print("medialist");
    print(mediasList);
    await mediasList['data'].forEach((media) async {
      print("media");
      print(media);
      // check inside db if exists (optional)
      Map<String, dynamic> m = await getMediaDetails(media['id']);
      InstaMedia instaMedia = InstaMedia(m);
      medias.add(instaMedia);
    });
    // need delay before returning the List<InstaMedia>
    await Future.delayed(Duration(seconds: 1), () {});
    return medias;
  }
  Future<Map<String, dynamic>> getMediaDetails(String mediaID) async {
    /// Parse according fieldsList.
    /// Request complete media informations.
    /// Returning the response as Map<String, dynamic>

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString(UiData.instagram_user_id);
    String token = prefs.getString(UiData.instagram_token);
    final String fields = mediaFields.join(',');
    final http.Response responseMediaSingle = await http.get(
        Uri.parse('https://graph.instagram.com/${mediaID}?fields=${fields}&access_token=${accessToken}'));
    print("mediadetail");
    print(responseMediaSingle.body);
    return json.decode(responseMediaSingle.body);
  }
}
class InstaMedia {
  late String id, type, url, username, timestamp;
  late bool selected;

  InstaMedia(Map<String, dynamic> m) {
    id = m['id'];
    type = m['media_type'];
    url = m['media_url'];
    username = m['username'];
    timestamp = m['timestamp'].toString();
    selected = false;
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "media_type": type,
      'media_url': url,
      'username': username,
      'timestamp': DateTime.now(),
    };
  }
/*  Future<List<InstaMedia>> getAllMedias() async {
    /// Parse according fieldsList.
    /// Request instagram user medias list.
    /// Request for each media id the details.
    /// Set all medias as list Object.
    /// Returning the List<InstaMedia>.
    final String fields = mediasListFields.join(',');
    final http.Response responseMedia = await http.get(
        'https://graph.instagram.com/${userID}/media?fields=${fields}&access_token=${accessToken}');
    Map<String, dynamic> mediasList = json.decode(responseMedia.body);
    medias = [];
    await mediasList['data'].forEach((media) async {
      // check inside db if exists (optional)
      Map<String, dynamic> m = await getMediaDetails(media['id']);
      InstaMedia instaMedia = InstaMedia(m);
      medias.add(instaMedia);
    });
    // need delay before returning the List<InstaMedia>
    await Future.delayed(Duration(seconds: 1), () {});
    return medias;
  }

  Future<Map<String, dynamic>> getMediaDetails(String mediaID) async {
    /// Parse according fieldsList.
    /// Request complete media informations.
    /// Returning the response as Map<String, dynamic>
    final String fields = mediaFields.join(',');
    final http.Response responseMediaSingle = await http.get(
        'https://graph.instagram.com/${mediaID}?fields=${fields}&access_token=${accessToken}');
    return json.decode(responseMediaSingle.body);
  }*/
}


typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  late Size oldSize;
  late final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    @required Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}