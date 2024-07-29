<img width="400px" src="https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/readme%2Flogo.png?alt=media&token=2c7c83f3-23df-4b4b-906b-6628bedf6f95" />

## AI-CUZA.ro
![GitHub license](https://img.shields.io/badge/license-MIT-green)
![Github issues](https://img.shields.io/badge/issues-0%20open-yellow)
## ⚠️ ATENȚIE: 
EinSaftOfficial este un cont creat de mine acum 3 ani pe care il folosesc pentru commit și push uri, prin VS Code in repository urile mele. Puteti verifica readme ul recuperatorului de sensuri.
### Tabel de conținut:
1. 🌐 [Informații generale](#informații-generale)
2. 🌐 [Ghid de instalare și utilizare](#ghid-de-instalare-și-utilizare)
3. 🌐 [Arhitectura aplicației](#arhitectura-aplicației)
4. 🌐 [Justificarea tehnologiilor alese](#justificarea-tehnologiilor-alese)

## 1. Informații generale

###  🚀 Ce își propune AI-CUZA.ro?
Platforma online AI.CUZA oferă un mediu de învățare accesibil tuturor, axat pe Design, Programare și Robotică, cu accent pe STEM. Interfața sa simplă și rețeaua socială integrată permit utilizatorilor să colaboreze, să împărtășească idei și să învețe împreună. Coach-ul AI și biblioteca vastă de resurse garantează sprijin continuu și acces la informații de calitate. Alăturați-vă comunității noastre și transformați-vă pasiunea pentru tehnologie în realitate cu Platforma AI.CUZA!

###  👥 Care este viziunea utilizatorilor?
Imaginați-vă un loc unde fiecare idee prinde viață și unde colaborarea este la ordinea zilei. În secțiunea de Proiecte a Platformei AI.CUZA, aveți ocazia să vă prezentați propriile proiecte de Design, Programare și Robotică, să primiți feedback valoros și să descoperiți inspirație de la alți pasionați.

Această secțiune nu este doar un spațiu de expunere, ci și un loc unde comunitatea se reunește pentru a inova și a învăța împreună. Puteți salva ideile preferate, să apreciați realizările altora și să participați activ la discuții care vă ajută să vă dezvoltați abilitățile.

## 2.🔧Ghid de instalare și utilizare

### 🖥 ️🌎 Accesarea online
Pentru accesarea platformei online, puteți folosi orice browser web major: Google Chrome, Microsoft Edge, Opera, Firefox, etc.), și accesați adresa https://ai-cuza.ro, însă este recomandată utilizarea Google Chrome pentru o experiență optimă.
### 👨‍💻 🛠️ Construirea aplicatiei
Alternativ, pentru a construi aplicația trebuie să aveți [Flutter 3.16 (cea mai recentă versiune compatibilă)](https://docs.flutter.dev/release/archive) și [Google Chrome (cea mai recentă versiune compatibilă)](https://www.google.com/chrome/) instalate pe sistem.
```
git clone https://github.com/tudordb12/AI-CUZA.ro
```
```
cd AICUZARO
```
```
flutter pub get
```
```
flutter run -d chrome --web-renderer html
```
```
flutter build web --web-renderer html
```

###  🔑 🖥️ Accesarea Platformei
După deschiderea url-ului, pentru a trece de Home View, va fi necesar să creați un cont de AI.CUZA, ale cărui date vor fi înregistrate în baze de date Firebase. După înregistrare, vă puteți loga și începe caracteristricile platformei.

## 3.📐👷🏻‍♂️ Arhitectura aplicației

###  🗃 ️Stack
Aplicația este construită utilizând următorul stack tehnologic:
- Flutter Dart (Cross - Platform, Optimizat pentru WEB)
- HTML
- JavaScript 
- Firebase Authentification
- Firebase Firestore
- Firebase Storage
- OPEN AI - Chat Gpt Turbo 3.5.1
  
[![My Skills](https://skillicons.dev/icons?i=dart,html,js,firebase,git,)](https://skillicons.dev)


###  🗃 Dart Packages
 
  stacked: ^3.4.0
  stacked_services: ^1.1.0
  url_strategy: ^0.2.0
  responsive_builder: ^0.7.0
  google_fonts: 6.1.0
  animate_do: ^3.3.4
  firebase_core: ^2.20.0
  firebase_auth: ^4.12.0
  firebase_database: ^10.4.0
  dash_chat_2: ^0.0.18
  chat_gpt_sdk: ^2.2.5
  image_picker: ^1.0.8
  firebase_storage: ^11.6.0
  cloud_firestore: ^4.14.0
  image_picker_web: ^3.1.1
  file_picker: ^8.0.0+1
  url_launcher: ^6.2.4
  flutter_dotenv: ^5.1.0
  like_button: ^2.0.5
  webview_flutter: ^2.0.4
  webview_flutter_web: ^0.1.0+1
  youtube_player_flutter: ^9.0.1



### 👨‍💻 Tehnici de programare
Am folosit mai mulți algoritmi pentru a optimiza aplicația, inclusiv:
- Programarea orientată pe obiect precum crearea claselor ce sunt responsabile de ViewRoutes și View urile ce conțin Scaffold-ul fiecărei pagini a platformei.
- Programarea asincronă pentru interacțiunea cu baza de date, permițând codului să aștepte răspunsuri de la baza de date.

### 💪🔒 Securitate
Am folosit mai mulți algoritmi pentru a optimiza aplicația, inclusiv:
- 📃🌐 Un SSL Certificate valid atașat domeniul ai-cuza.ro, ce adaugă un strat de securitate ce criptează traficul informațiilor de conectare ale utilizatorilor, ale postărilor și preferințelor acestora.
- 🔥👤 Utilizarea Firebase Auth pentru stocarea criptată online a datelor de logare ale utilizatorilor platformei.
- 🔑🔒 Protecția API Key urilor de OpenAI, ce se accesează prin intermediul unei baze de date securizate.

### 🖌User Interface

### Arhitectura MVVM
Proiectul AI-CUZA.ro folosește arhitectura MVVM (Model-View-ViewModel) pentru un cod organizat și ușor de întreținut. Modelul gestionează datele și regulile aplicative, ViewModel-ul le expune pentru a fi utilizate de interfață, iar View-ul afișează informațiile utilizatorilor. Pentru a accelera dezvoltarea și a asigura consistența, folosim stacked CLI, un tool robust pentru generarea și gestionarea structurii MVVM.

Scopul nostru a fost să creăm interfețe responsive pentru DesktopView, MobileView și TabletView, oferind o experiență optimizată pe diverse dispozitive. Această combinație de MVVM și stacked CLI facilitează gestionarea funcționalităților complexe, asigurând actualizări și extinderi ușoare. Astfel, AI-CUZA.ro se dezvoltă agil și robust, oferind utilizatorilor o platformă performantă și adaptabilă.

## 4. De ce am ales aceste tehnologii?

1. Flutter Dart (Cross-Platform, Optimizat pentru WEB)
Permite dezvoltarea pentru multiple platforme (web, mobile, desktop) cu un singur cod, economisind timp și resurse.
Oferă performanță ridicată și experiență fluidă pentru utilizatori.
2. HTML și JavaScript
Standard web universal, garantând compatibilitate și flexibilitate.
Acces la o vastă comunitate de dezvoltatori și resurse.
3. Firebase Authentication, Firestore și Storage
Autentificare securizată și rapidă pentru gestionarea utilizatorilor.
Stocare și sincronizare a datelor în timp real, esențiale pentru funcționalități interactive.
Soluții scalabile și securizate pentru stocarea fișierelor educaționale și multimedia.
4. OPEN AI - Chat GPT Turbo 3.5.1
Asistență AI avansată pentru suport în învățare și rezolvarea problemelor.
Recomandări personalizate, adaptate nevoilor fiecărui utilizator.

Din punct de vedere tehnologic, proiectul oferă o soluție logică și clară pentru ecranele platformei:
- **Login și Sign Up:** Interfețe sigure, integrate cu Firebase Auth encryption pentru autentificarea utilizatorilor.
- **Home View:** Prima pagină a platformei web, care te redirecționează către pagina de Autentificare.
- **Posts View:** Afișează datele stocate din baza de date sub forma postărilor ce au funcțiile de like, comment, save și follow.
- **Profile View:** Pagina unde ai acces și poți gestiona propriile postări, lista de urmăriri și ideile salvate/preferate.
- **AI COACH:** Oferă suport 24/24 pentru orice problemă întâmpinată de utilizatori, cu răspunsuri documentate și înșușite din training-ul anterior al modelului OpenAI.
- **Etc.**
  ## Platforma AI.CUZA
### Paginile Aplicației

<div style="display: flex; justify-content: center;">
    <img width="800px" src="https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/readme%2FScreenshot%202024-07-29%20at%2014.06.12.png?alt=media&token=3f0a3ac1-9c3e-4b39-abd0-d79222bb65f3" />
    <img width="800px" src="https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/readme%2FScreenshot%202024-07-29%20at%2014.07.17.png?alt=media&token=df9d40f5-ac01-44ce-afda-5be3bba2039e" />
    <img width="800px" src="https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/readme%2FScreenshot%202024-07-29%20at%2015.24.44.png?alt=media&token=d05bd933-de5f-424d-866e-e2840bbd42a5" />
  <img width="200px" src="https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/readme%2FScreenshot%202024-07-29%20at%2016.19.12.png?alt=media&token=b8592630-80ce-4ebf-930d-4a0b7b512e3f" />
  </div>

## ❔ Realizator
- Profesor Coordonator: Dna. Rădulescu Ramona
- Membrii:
  - Durduman - Burtescu Tudor

