// Created by AMIT JANGID on 07/01/21.

const String kRupeeSymbol = '₹';
const String kVersion = 'Version';
const String kAppName = 'Housing Society App';
const String kDatabaseName = 'HousingSociety.db';

const String kTimeFormat = 'HH:mm:ss';
const String kDateFormat = 'yyyy-MM-dd';
const String kTimeDateFormat = 'hh:mm a, dd-MM-yyyy';

//#region GENERAL STRINGS

const String kNo = 'No';
const String kYes = 'Yes';
const String kSave = 'Save';
const String kInfo = 'Info';
const String kError = 'Error';
const String kSuccess = 'Success';
const String kWarning = 'Warning';

const String kBook = 'Book';
const String kMaid = 'Maid';
const String kGuest = 'Guest';
const String kParcel = 'Parcel';
const String kRefuse = 'Refuse';
const String kPaidOn = 'Paid On';
const String kPayNow = 'Pay Now';
const String kCharges = "Charges";
const String kApprove = 'Approve';
const String kPayments = 'Payments';
const String kVisitors = 'Visitors';
const String kUpcoming = 'Upcoming';
const String kApproved = 'Approved';
const String kWelcome = 'Welcome!! ';
const String kDashboard = 'Dashboard';
const String kAvailable = "Available";
const String kBillMonth = 'Bill Month';
const String kFacilities = 'Facilities';
const String kAddVisitor = 'Add Visitor';
const String kWrongEntry = 'Wrong Entry';
const String kUnApproved = 'Not Approved';
const String kDailyVisitor = 'Daily Visitor';
const String kVisitingDate = "Visiting Date";
const String kGoogleSignIn = 'Google Sign In';
const String kVisitorsName = "Visitor's Name";
const String kVisitorsType = "Visitor's Type";

//#endregion GENERAL STRINGS

//#region SHARED PREFERENCES STRINGS

const String kPrefsIsFacilityDataInserted = 'isFacilityDataInserted';

//#endregion SHARED PREFERENCES STRINGS

//#region ICONS STRINGS

const String kIconHome = "assets/icons/home.png";
const String kIconPerson = "assets/icons/person.jpg";
const String kIconGoogle = "assets/icons/google.png";
const String kIconVisitors = "assets/icons/visitors.png";
const String kIconPayments = "assets/icons/payments.png";
const String kIconFacilities = "assets/icons/facilities.png";

//#endregion ICONS STRINGS

//#region MESSAGE STRINGS

const String kNoRecords = "No Records Found";
const String kEnterVisitorsName = "Please enter Visitor's Name";
const String kEnterVisitorsType = "Please enter Visitor's Type";
const String kSelectVisitingDate = "Please select Visiting Date";
const String kVisitorSavedFailedMsg = "Visitor's data was not saved.";
const String kLoginFailedMsg = "Unable to login. Please try again later.";
const String kInternetNotAvailable = "Internet connection not available.";
const String kVisitorSavedSuccessMsg = "Visitor's data saved successfully.";

//#endregion MESSAGE STRINGS

//#region COLLECTIONS STRINGS

const String kUsersCollection = 'users';
const String kPaymentsCollection = 'payments';
const String kVisitorsCollection = 'visitors';

//#endregion COLLECTIONS STRINGS

//#region FIELDS STRINGS

// users collection fields
const String kFieldUid = 'uid';
const String kFieldName = 'name';
const String kFieldEmail = 'email';
const String kFieldState = 'state';
const String kFieldStatus = 'status';
const String kFieldUserName = 'username';
const String kFieldProfilePhoto = 'profile_photo';

// payments collection fields
const String kFieldPaid = 'paid';
const String kFieldAmount = 'amount';
const String kFieldPaidOn = 'paid_on';
const String kFieldBillMonth = 'bill_month';
const String kFieldDescription = 'description';

// visitors collection fields
const String kFieldApproved = 'approved';
const String kFieldVisitorName = 'visitor_name';
const String kFieldVisitorType = 'visitor_type';
const String kFieldDailyVisitor = 'daily_visitor';
const String kFieldVisitingDate = 'visiting_date';
const String kFieldVisitorPhoto = 'visitor_photo';

//#endregion FIELDS STRINGS

//#region DB TABLE NAME STRINGS

const String kTableFacility = 'Facility';

//#endregion DB TABLE NAME STRINGS

//#region DB COLUMN NAME STRINGS

const String kColumnCode = 'Code';
const String kColumnFacilityName = 'FacilityName';
const String kColumnFacilityImage = 'FacilityImage';
const String kColumnFacilityCharges = 'FacilityCharges';
const String kColumnFacilityAvailable = 'FacilityAvailable';

//#endregion DB COLUMN NAME STRINGS
