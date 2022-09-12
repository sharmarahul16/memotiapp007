import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String get labelWelcome;
  String get labelInfo;
  String get labelSelectLanguage;


  String get Home;

  String get Creations;

  String get Cart;

  String get Account;

  String get ProductsWeOffer;

  String get SomeThingwentwrong;

  String get Tryagain;
  String get NOorderItems;

  String get AddAddress;

  String get Whereshouldwesendthosewonderfulphotos;

  String get Address;

  String get CityStreet;

  String get PostCode;

  String get PhoneNumber;

  String get SaveAddress;
  String get Save;
  String get Office;
  String get Others;

  String get CountryRegion;
  String get India;
  String get Uk;

  String get Addresses;

  String get AddNewAddress;

  String get Done;

  String get Edit;

  String get WallCalendarA3;
  String get Preview;
  String get WallCalender;
  String get From;
  String get MakePlaning;
  String get SuperPersonalisable;
  String get ImaportantDates;
  String get AUniqueGift;
  String get Getmoredetails;
  String get DimensionsA3A4A5LandscapeA3A4A5Portrait;
  String get Customizewithphotoslayoutscoloursimportantdates;
  String get CreateNow;
  String get Previews;
  String get Mon;
  String get Tue;
  String get Wed;
  String get Thu;
  String get Fri;
  String get Sat;
  String get Sun;
  String get Youcanchoosethemonthwhenyouwantittostartitdoesnthavetobeanuary;

  String get LetsGo;
  String get Poster;
  String get cms;
  String get Canvas;

  String get TestingYourCreativity;
  String get FeelingLikeAnArtCollector;
  String get BringingYourHallwayToLife;
  String get GiftingSomeoneoflove;

  String get Formatsavailable;
  String get Dimensions20cm30cm40cm50cm60cm;
  String get Possibiltytochooseprintingtoedgeorprintingovertheedge;
  String get Ifprintingedgethanpossibiltytochoosecanvasbackgroundcolor;
  String get Weguaranteeaqualityservisenmaximumprotectingduringtransportifyourcanvasarrivesdamagedwellreprintitforyou;
  String get AddtoCart;
  String get Size;
  String get Border;
  String get Thickness;
  String get RotateLeft;
  String get RotateRight;
  String get Format;
  String get Rotate;
  String get Zoom;
  String get Premiumpaper;
  String get Replace;
  String get Printingoveredge;
  String get Printingtoedge;
  String get ThinFrame;
  String get StandardFrame;
  String get NoProductoncart;
  String get Total;
  String get AddMoreProducts;
  String get Checkout;
  String get Coilbinding;
  String get Buy;
  String get pages;
  String get ThereisnothingincartPleaseaddbyclickonbelowbutton;
  String get ThereisnothingincreationPleaseaddbyclickonbelowbutton;
  String get Ok;
  String get WelcomeBack;
  String get Chooseyoursigninmethodbelow;
  String get Enteryouremail;
  String get Password;
  String get Login;
  String get Pleasefillalldetails;
  String get Donthaveanaccount;
  String get Signup;
  String get ContinueWithFacebook;
  String get ThanksforLoginNowcreateyourmemories;
  String get FacingtheissueinLogintheuserPleasetryagainwithloginwithsameemailaddress;
  String get FacingtheissueinregisteringtheuserPleasetryagainwithloginwithsameemailaddress;
  String get Logincancelledbytheuser;
  String get SomethingwentwrongwiththeloginprocessHerestheerrorFacebookgaveus;
  String get Createanewaccount;
  String get SignUpHere;
  String get FirstName;
  String get LastName;
  String get EmailAddress;
  String get Email;
  String get SignUp;
  String get faceSomeIssuepleasetryagain;
  String get SignupSuccessfullyNowcreateyourmemories;
  String get FaceSomeissuepleaseTrytologinwiththissameemailaddress;
  String get OrderDetails;
  String get ShippingAddress;
  String get title;
  String get address;
  String get postCode;
  String get cityRegion;
  String get Country;
  String get PriceSummary;
  String get ItemPrice;
  String get price;
  String get TotalPrice;
  String get Thankufororderingfromuswewillcontactyousoon;
  String get Next;
  String get Close;
  String get OrderHistory;
  String get Last3months;
  String get FilterOrders;
  String get ViewOrders;
  String get OrderSummary;
  String get OrderStatus;
  String get Delivered;
  String get Numberofitems;
  String get ShippingPayment;
  String get Discount;
  String get BuyitAgain;
  String get Album;
  String get Pleaseselectlayout;
  String get Photos;
  String get Layout;
  String get Flip;
  String get Filters;
  String get Text;
  String get Enteryourmessage;
  String get ChooseFont;
  String get Font;
  String get FontColor;
  String get Continue;
  String get BgColor;
  String get Dimensions1515cm3030cmA4A5PortraitA4A5Landscape;
  String get Bindingcoilspin;
  String get Pagecounts;
  String get Coilbinding2096stran;
  String get Spinbinding2036stran;
  String get Page;
  String get oF;
  String get Gotopage;
  String get ChooseOptions;
  String get Binding;
  String get UnderWorking;
  String get Thereisnoimagesinyourgooglephoto;
  String get GoogleSignin;
  String get ChooseArtist;
  String get SelectCategory;
  String get Alert;
  String get AddNote;
  String get PhoneGallery;
  String get MemotiGallery;
  String get GooglePhoto;
  String get Facebook;
  String get Instagram;
  String get SelectPhoto;
  String get Selected;
  String get UnselectAll;
  String get PhotogalleryimageslengtharelessthanminimumphotorequirementYouhavetoaddmoreimagesorchoodeotheroption;
  String get waitforamoment;
  String get AutoSelect;
  String get Youcanselectmorethan100photos;
  String get Youwillhavetoselectminimum10photos;
  String get Chooseimages;
  String get Camera;
  String get processingdata;
  String get Exit;
  String get Cancel;
  String get EnvironmentFriendly;
  String get RigidDurable;
  String get Customizewithphotos;
  String get Organiseyouryearmomentsbymomentsinauniquepersonalisedcalendar;
  String get ShareApp;
  String get HelpContact;
  String get ContactUs;
  String get PaymentMethod;
  String get MyAddresses;
  String get Processing;
  String get Logout;
  String get SignupwithMail;
  String get SignupwithFacebook;
  String get Alreadyhaveanaccount;
  String get LoginNow;
  String get PrivacyPolicy;
  String get TermsConditions;
  // new strigs
  String get EditAddress;
  String get Fullname;
  String get city;
  String get delete;
  String get CardDetail;
  String get Ihavereadandaccepttermsandconditions;
  String get submit;
  String get Thereisnothinginorderlist;
  String get Weneedrequirethesepermissiontoprovideyouabetterexperince;
  String get openappsetting;
  String get Gettingphotos;
  String get WeareprocessingthephotosPLeasewait;
  String get Youcanselectminimumphotos;
  String get AddCardDetail;
  String get PaymentOption;
  String get NoCardaddedyet;
  String get Gettingcards;
  String get AddNewCard;
  String get CashonDelievery;
  String get Cvvshouldcontain3characters;
  String get ChangeLanguage;
  String get Delete;
  String get ProjectList;
  String get PLeaseEnterValidEmailAddressAndPassowrd;
  String get Remove;
  String get Youmustaddimageatthispostion;
  String get Youmustaddimagesonthesepostions;
  String get ImageQualityislow;
  String get ImageQualityisverylow;
  String get SelectOption;
  String get Help;
  String get undo;
  String get redo;

}