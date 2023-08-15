import 'package:flutter/material.dart';
import 'dart:math';

// New Color theme
const primaryColor = Color(0xff25C9ED);
const scaffoldColor = Color(0xffFAFBFE);
const darkGreyColor = Color(0xff727884);
const lightGreyColor = Color(0xffD0D0D0);
const lightBlueColor = Color(0xffEEFAFF);
const typingColor = Color(0xff303950);

const defaultScreenPadding = 18.0;
const defaultHeightSpacing = 26.0;
const defaultListViewItemsPadding = 12.0;

//Sharedprefs
const String kTokenSave = 'ktokensave';
const String kLangSave = 'klangsave';
const String kuuid = 'kuuid';
const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
//Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

//traduction :
const String kLanguageScreenTitleEn = "Welcome to Medilink";
const String kLanguageScreenTitleFr = "Bienvenue au Medilink";
const String kLanguageScreenEn = "Select your language";
const String kLanguageScreenFr = "Select your language";
const String kbutton1En = "Next";
const String kbutton1Fr = "Suivant";
const String kGetStartedEn = "Get Started";
const String kGetStartedFr = "Commencer";
const String ktitle1En = "Medilink";
const String ktitle2En = "Comprehensive Specialist Network";
const String ktitle3En = "Virtual Healthcare Support";
const String ktitle1Fr = "Medilink";
const String ktitle2Fr = "Réseau d'Experts à votre\n service";
const String ktitle3Fr = "Soutien Médical Virtuel Réinventé";
const String kdiscruption1En =
    "Seamlessly connect with your doctors and manage your medical records right from your fingertips!";
const String kdiscruption2En =
    "Access a diverse range of specialized doctors all in one place.";
const String kdiscruption3En =
    "Experience virtual healthcare support anywhere through text, audio, and video calls.";
const String kdiscruption1Fr =
    "Établissez un lien fluide avec vos médecins et gérez aisément vos dossiers médicaux, le tout au bout de vos doigts !";
const String kdiscruption2Fr =
    "Découvrez une multitude de médecins spécialisés, réunis en un seul lieu.";
const String kdiscruption3Fr =
    "Profitez d'un accompagnement médical virtuel, où que vous soyez, grâce à des appels textes, audio et vidéo.";
const String kEmailNullErrorEn = "Please Enter your email";
const String kInvalidEmailErrorEn = "Please Enter Valid Email";
const String kPassNullErrorEn = "Please Enter your password";
const String kShortPassErrorEn = "Password is too short";
const String kconfirmPassNullErrorEn = 'Please enter re-password';
const String kMatchPassErrorEn = "password do not match";
const String kNamelNullErrorEn = "Please Enter your name";
const String kFirstNamelNullErrorEn = "Please Enter your firstname";
const String kLastNamelNullErrorEn = "Please Enter your lastname";
const String kTypeNullErrorEn = "Please Enter the type field";
const String kPhoneNumberNullErrorEn = "Please Enter your phone number";
const String kAddressNullErrorEn = "Please Enter your address";
const String kRoleNullErrorEn = "Please Enter your role ";
const String kGenderNullErrorEn = "Please Enter your Gender ";
const String kNamevalidationErrorEn =
    'Please enter a valid name (letters only)';
const String kPhoneNumberValidationEn = 'Please enter a valid phone number';
const String kbirthdateValidationEn = 'Please enter a valid birthdate';
const String kSpecializationNullErrorEn =
    "Please Enter a valid specialization ";
const String kdescriptionvalidationEn = "Please Enter less then 3 lines ";
const String ksigninEn = "Sign In";
const String kwelcomeEn = "Welcome Back";
const String kcontinueEn = "Sign in with your email and password";
const String knoacountEn = "Don't have  an account!";
const String ksignupEn = "Sign Up";
const String kerror1En = 'Unable to connect to the server.\n Please try again.';
const String kerror2En = 'An unexpected error occurred.\n Please try again.';
const String kremembermeEn = "Remember me";
const String kforgetpasswordEn = "Forgot Password";
const String kemailEn = "Email";
const String kpasswordEn = "Password";
const String kconfirmpasswordEn = "Confirm Password";
const String kfirstnameEn = "First Name";
const String klastnameEn = "Last Name";
const String kphonenumberEn = "Phone Number";
const String kphonenumberhintEn = "Enter your phone number";
const String kaddressEn = "Address";
const String kaddresshintEn = "Enter your address";
const String kbirthdateEn = "date of birth";
const String ktypeEn = "Type";
const String kspecializationEn = "Speciality";
const String kspecializationhintEn = "Enter your speciality";
const String kdescriptionEn = "Description";
const String kemailhintEn = "Enter your email";
const String kpasswordhintEn = "Enter your password";
const String kconfirmpasswordhintEn = "Enter your confirm password";
const String kfirstnamehintEn = "Enter your first name";
const String klastnamehintEn = "Enter your last name";
const String knamehintEn = "Enter your name";
const String kregisterEn = "Register Account";
const String kcompletewithEn = "Complete your details ";
const String kconditionsEn =
    'By continuing your confirm that you agree \nwith our Term and Condition';
const String knameEn = "Name";
const String kpatientEn = 'Patient';
const String kproviderEn = 'Health care provider';
const String kcompletEn = "Complete Profile";
const String kbirthdatehintEn = "ex : 14-07-1988";
const String kAboutEn = "About";
const String kAbouthintEn = "I am a doctor";
const String khintEn = "Write about yourself";
const String kmaleEn = "Male";
const String kfemaleEn = "Female";
const String kSearchEn = "Search";
const String kOtpTitleEn = "Co\nDE";
const String kOtpsubTitleEn = "verification";
const String tOtpMessageEn = "Enter the verifification code";
const String kForgetpasswordTitleEn = "Make Selection";
const String kForgetPasswordSubTitleEn =
    "Select one of the options given below to reset your password.";
const String kResetViaEmailEn = "Reset via Mail Verification";
const String kResetViaPhoneEn = "Reset via Phone Verification";
const String kForgetPhoneSubtitleEn =
    "Enter your registred Phone Number to receive OTP";
const String kForgetEmailSubtitleEn =
    "Enter your registred E-Mail Address to receive OTP";
const String kverificationEn = "verification";
const String kemailverificationEn = "Verify your email address";
const String kemailverificationSubtitleEn =
    "We have just send email veriffication link on your email. Please check email and click on that link to verify your email address.\n\nif not auto redirected after verification,click on the Continue button.";
const String kresendemailLinkEn = "Resend E-Mail Link";
const String tbackToLoginEn = "back to login";
const String kchossepicEn = "Choose Profile photo";
const String kcameraEn = "Camera";
const String kselectimageEn = 'Select Image';
const String kbuildingpicEn = "Choose building Picture";
const String kSearchFr = "Rechercher";
const String kEmailNullErrorFr = "Veuillez entrer votre adresse e-mail";
const String kInvalidEmailErrorFr = "Veuillez entrer une adresse e-mail valide";
const String kPassNullErrorFr = "Veuillez entrer votre mot de passe";
const String kShortPassErrorFr = "Le mot de passe est trop court";
const String kconfirmPassNullErrorFr =
    'Veuillez entrer à nouveau votre mot de passe';
const String kMatchPassErrorFr = "Les mots de passe ne correspondent pas";
const String kNamelNullErrorFr = "Veuillez entrer votre nom";
const String kFirstNamelNullErrorFr = "Veuillez entrer votre prénom";
const String kLastNamelNullErrorFr = "Veuillez entrer votre nom de famille";
const String kTypeNullErrorFr = "Veuillez entrer le champ de type";
const String kPhoneNumberNullErrorFr =
    "Veuillez entrer votre numéro de téléphone";
const String kAddressNullErrorFr = "Veuillez entrer votre adresse";
const String kRoleNullErrorFr = "Veuillez entrer votre rôle";
const String kGenderNullErrorFr = "Veuillez entrer votre genre";
const String kNamevalidationErrorFr =
    'Veuillez entrer un nom valide (lettres uniquement)';
const String kPhoneNumberValidationFr =
    'Veuillez entrer un numéro de téléphone valide';
const String kbirthdateValidationFr =
    'Veuillez entrer une date de naissance valide';
const String kSpecializationNullErrorFr =
    "Veuillez entrer une spécialisation valide";
const String kdescriptionvalidationFr = "Veuillez entrer moins de 3 lignes";
const String kwelcomeFr = "Bienvenue";
const String kcontinueFr =
    "Connectez-vous avec votre e-mail et votre mot de passe";
const String knoacountFr = "Vous n'avez pas de compte !";
const String ksignupFr = "S'inscrire";
const String kerror1Fr =
    "Impossible de se connecter au serveur.\nVeuillez réessayer.";
const String kerror2Fr =
    "Une erreur inattendue s'est produite.\nVeuillez réessayer.";
const String kremembermeFr = "Se souvenir de moi";
const String kforgetpasswordFr = "Mot de passe oublié";
const String kemailFr = "Email";
const String kpasswordFr = "Mot de passe";
const String kconfirmpasswordFr = "Confirmer le mot de passe";
const String kfirstnameFr = "Prénom";
const String klastnameFr = "Nom de famille";
const String kphonenumberFr = "Numéro de téléphone";
const String kaddressFr = "Adresse";
const String ktypeFr = "Type";
const String kspecializationFr = "Spécialité";
const String kdescriptionFr = "Description";
const String kemailhintFr = "Entrez votre adresse e-mail";
const String kpasswordhintFr = "Entrez votre mot de passe";
const String kconfirmpasswordhintFr =
    "Entrez votre mot de passe de confirmation";
const String kfirstnamehintFr = "Entrez votre prénom";
const String klastnamehintFr = "Entrez votre nom de famille";
const String knamehintFr = "Entrez votre nom";
const String kregisterFr = "Créer un compte";
const String kcompletewithFr = "Complétez vos informations";
const String kconditionsFr =
    "En continuant,\n vous confirmez que vous acceptez \nnos conditions générales d'utilisation";
const String knameFr = "Nom";
const String kpatientFr = "Patient";
const String kproviderFr = "Fournisseur de soin";
const String kcompletFr = "complétez votre profil";
const String kaddresshintFr = "Entrez votre adresse";
const String kphonenumberhintFr = "Entrez votre numéro de téléphone";
const String kbirthdateFr = "Date de naissance";
const String kbirthdatehintFr = "ex : 14-07-1988";
const String kspecializationhintFr = "Entrez votre spécialité";
const String kAboutFr = "À propos";
const String khintFr = "écrire sur vous";
const String kAbouthintFr = "Je suis médecin";
const String kmaleFr = "Homme";
const String kfemaleFr = "Femme";
const String kOtpTitleFr = "Code";
const String kOtpsubTitleFr = "Vérification";
const String tOtpMessageFr = "Entrez le code de vérification ";
const String kForgetpasswordTitleFr = "Faire une sélection";
const String kForgetPasswordSubTitleFr =
    "Sélectionnez l'une des options ci-dessous pour réinitialiser votre mot de passe.";
const String kResetViaEmailFr =
    "Réinitialiser via la\n vérification par e-mail";
const String kResetViaPhoneFr =
    "Réinitialiser via la vérification par téléphone";
const String kForgetPhoneSubtitleFr =
    "Entrez votre numéro de téléphone enregistré pour recevoir le code de vérification";
const String kForgetEmailSubtitleFr =
    "Entrez votre adresse e-mail enregistrée pour recevoir le code de vérification";
const String kverificationFr = "vérification";
const String kemailverificationFr = "Vérifiez votre adresse e-mail";
const String kemailverificationSubtitleFr =
    "Nous venons d'envoyer un lien de vérification par e-mail à votre adresse e-mail. Veuillez vérifier votre e-mail et cliquer sur ce lien pour vérifier votre adresse e-mail.\n\nSi vous n'êtes pas redirigé automatiquement après la vérification, cliquez sur le bouton Continuer.";
const String kresendemailLinkFr = "Renvoyer le lien par e-mail";
const String tbackToLoginFr = "Retour à la page de connexion";
const String kchossepicFr = "Choisissez une photo de profil";
const String kcameraFr = "Appareil photo";
const String kselectimageFr = "Sélectionner une image";
const String kbuildingpicFr = "Choisir une image du bâtiment";
const String ksigninFr = "Se connecter";
const String ktyperegisterEn = "Select your role";
const String ktyperegisterhintEn =
    "Join as a Doctor, Patient, Laboratory, or Pharmacy";
const String ktyperegisterFr = "Choisissez votre rôle";
const String ktyperegisterhintFr =
    "Rejoignez en tant que Médecin, Patient, Laboratoire ou Pharmacie";
const String kEnglishEn = "English";
const String kFrenchEn = "French";
const String kEnglishFr = "Anglais";
const String kFrenchFr = "Français";
const String kaddallergieEn = "Add Allergy";
const String keditallergieEn = "Edit Allergy";
const String kuserallergiesEn = "Allergys";
const String kaddallergieFr = "Ajouter une Allergie";
const String keditallergieFr = "Modifier l'Allergie";
const String kuserallergiesFr = "Allergies";

//images :
const String kForgetPassImage = "assets/images/forgot-password.png";
const String kProfile = "assets/images/avatar.jpg";
const String kBuilding = "assets/images/building.jpg";

List<Map<String, dynamic>> doctors = [
  {
    "type": "Doctor",
    "role": "Doctor",
    "firstname": "Dr Ali",
    "lastname": "Ben Salem",
    "speciality": "Orthodentist",
    "picture": "assets/images/doctor.png",
    "address": "Hôpital sahloul",
    "email": "alibensalem@medilink.com",
    "phoneNumber": "54367184",
    "buildingPictures": [
      "https://imagecdn.med.ovh/unsafe/0x0/filters:format(webp):quality(80):blur(0)/https://www.med.tn/uploads/offices/f421b91963581e8949601615228175.jpeg"
    ],
    "description":
        "Spécialiste en Dentisterie Esthétique Chirurgie Dentiste Diplomé de la Faculté de Médecine Dentaire de Monastir",
    "licenseVerificationCode": "",
  },
  {
    "type": "Doctor",
    "role": "Doctor",
    "firstname": "Dr Azza",
    "lastname": "Ayedi",
    "speciality": "Cardiologist",
    "picture": "assets/images/doctor2.png",
    "address": "21 Avenu Ali Bahlouen",
    "email": "azzaayed@medilink.com",
    "phoneNumber": "22478987",
    "buildingPictures": [],
    "description":
        "Néphrologue Professeur en néphrologie faculté de médecine de sousse Ancien chef service de néphrologie hôpital Sahloul sousse",
    "licenseVerificationCode": "",
  },
  {
    "type": "Doctor",
    "role": "Doctor",
    "firstname": "Dr Amir",
    "lastname": "Zayani",
    "speciality": "Orthodentist",
    "picture": "assets/images/doctor3.png",
    "address": "Monastir centre",
    "email": "amirzayani@medilink.com",
    "phoneNumber": "71876449",
    "buildingPictures": [
      "https://imagecdn.med.ovh/unsafe/0x0/filters:format(webp):quality(80):blur(0)/https://www.med.tn/uploads/offices/27491_1-cabinet-dr-ines-aloui-hachicha.jpg",
      "https://imagecdn.med.ovh/unsafe/0x0/filters:format(webp):quality(80):blur(0)/https://www.med.tn/uploads/offices/27491_2-cabinet-dr-ines-aloui-hachicha.jpg"
    ],
    "description":
        "Spécialiste des Maladies et Chirurgie des Yeux Ancien Assistant Hospitalo-Universitaire en Ophtalmologie Ancien Attaché des Hopitaux de Paris(France)",
    "licenseVerificationCode": "",
  },
];

List<Map<String, dynamic>> specialistes = [
  {
    "image": "assets/icons/cardiogram.png",
    "name": "Cardiology",
    "theme": const Color.fromARGB(235, 237, 90, 92),
  },
  {
    "image": "assets/icons/brain.png",
    "name": "Neurology",
    "theme": const Color.fromARGB(212, 133, 147, 235),
  },
  {
    "image": "assets/icons/tooth.png",
    "name": "Dental",
    "theme": const Color.fromARGB(208, 86, 189, 226),
  },
  {
    "image": "assets/icons/eye.png",
    "name": "Ophthalmology",
    "theme": const Color.fromARGB(203, 226, 87, 161),
  },
  {
    "image": "assets/icons/lungs.png",
    "name": "Pulmonology",
    "theme": Color.fromARGB(185, 0, 150, 136),
  },
  {
    "image": "assets/icons/bone.png",
    "name": "Orthopedics",
    "theme": Color.fromARGB(180, 0, 170, 255),
  },
  {
    "image": "assets/icons/stethoscope.png",
    "name": "General Medicine",
    "theme": Color.fromARGB(150, 0, 192, 87),
  },
  {
    "image": "assets/icons/mental-health.png",
    "name": "Psychiatry",
    "theme": Color.fromARGB(180, 171, 71, 188),
  },
];

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255, // Alpha (opacity), set to 255 for full opacity
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
  );
}
