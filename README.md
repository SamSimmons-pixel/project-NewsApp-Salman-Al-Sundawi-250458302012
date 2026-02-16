# Zone News - News Application

![Flutter](https://img.shields.io/badge/Flutter-3.10.7-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10.7-0175C2?logo=dart)
![License](https://img.shields.io/badge/license-MIT-green)

## 📱 Deskripsi Project

**Zone News** adalah aplikasi berita modern yang dibangun menggunakan Flutter. Aplikasi ini memanfaatkan News API untuk menampilkan berita terkini dari berbagai kategori seperti bisnis, teknologi, kesehatan, sains, olahraga, hiburan, dan dunia. Dengan antarmuka yang modern dan responsif, pengguna dapat dengan mudah menjelajahi berita terbaru, mencari artikel spesifik, dan berbagi berita kepada orang lain.

### ✨ Fitur Utama

- 📰 **Berita Terkini**: Menampilkan headline berita terbaru dari berbagai sumber
- 🔍 **Pencarian Berita**: Mencari artikel berita berdasarkan kata kunci
- 📂 **Kategori Berita**: Filter berita berdasarkan kategori (bisnis, teknologi, kesehatan, dll)
- 🌐 **WebView**: Membaca artikel lengkap dalam aplikasi
- 🔗 **Berbagi Berita**: Bagikan artikel ke platform lain
- 💾 **Cache Gambar**: Caching gambar untuk performa yang lebih baik
- 🎨 **UI Modern**: Desain antarmuka yang menarik dengan gradien dan animasi

## 🛠️ Teknologi yang Digunakan

### Framework & Language

- **Flutter** (SDK 3.10.7) - Framework UI untuk pengembangan cross-platform
- **Dart** - Bahasa pemrograman

### State Management & Routing

- **GetX** (^4.7.3) - State management, dependency injection, dan route management

### Networking & Data

- **HTTP** (^1.6.0) - HTTP client untuk API calls
- **News API** - API penyedia berita global

### UI & UX Components

- **Cached Network Image** (^3.4.1) - Caching dan loading gambar dari network
- **WebView Flutter** (^4.13.1) - Menampilkan konten web dalam aplikasi
- **TimeAgo** (^3.7.1) - Format waktu relatif (e.g., "2 jam yang lalu")

### Utilities

- **Share Plus** (^12.0.1) - Berbagi konten ke platform lain
- **URL Launcher** (^6.3.2) - Membuka URL eksternal
- **Flutter DotEnv** (^6.0.0) - Manajemen environment variables

### Development Tools

- **Flutter Lints** (^6.0.0) - Linting rules untuk kode yang lebih baik

## 📋 Prasyarat

Sebelum menjalankan project ini, pastikan Anda telah menginstal:

- **Flutter SDK** (versi 3.10.7 atau lebih tinggi)
  - Download dari: https://flutter.dev/docs/get-started/install
- **Dart SDK** (sudah termasuk dalam Flutter)
- **Android Studio** / **VS Code** dengan plugin Flutter
- **Android Emulator** / **iOS Simulator** / **Physical Device**
- **News API Key**
  - Daftar gratis di: https://newsapi.org/register

## 🚀 Langkah Menjalankan Aplikasi

### 1. Clone Repository

```bash
git clone https://github.com/username/indian_hoax_news.git
cd indian_hoax_news
```

### 2. Install Dependencies

Jalankan perintah berikut untuk menginstall semua package yang dibutuhkan:

```bash
flutter pub get
```

### 3. Konfigurasi API Key

Buat file `.env` di root project dan tambahkan API key Anda:

```bash
# .env
API_KEY=your_newsapi_key_here
```

**Cara mendapatkan API Key:**

1. Kunjungi https://newsapi.org/
2. Klik "Get API Key" atau "Register"
3. Isi form registrasi
4. Copy API key yang diberikan
5. Paste ke file `.env`

### 4. Verifikasi Instalasi Flutter

Pastikan Flutter terinstall dengan benar:

```bash
flutter doctor
```

Perbaiki masalah yang muncul (jika ada) sebelum melanjutkan.

### 5. Jalankan Aplikasi

#### Menggunakan Emulator/Simulator:

```bash
# Jalankan di mode debug
flutter run

# Atau spesifik device
flutter run -d chrome          # Web
flutter run -d windows         # Windows Desktop
flutter run -d android         # Android
flutter run -d ios             # iOS (Mac only)
```

#### Menggunakan Physical Device:

1. Hubungkan device via USB
2. Enable USB Debugging (Android) atau Trust Computer (iOS)
3. Jalankan:

```bash
# Cek device yang terhubung
flutter devices

# Jalankan di device
flutter run
```

### 6. Build untuk Production

#### Android (APK):

```bash
flutter build apk --release
```

File APK akan tersimpan di: `build/app/outputs/flutter-apk/app-release.apk`

#### Android (App Bundle):

```bash
flutter build appbundle --release
```

#### iOS:

```bash
flutter build ios --release
```

#### Web:

```bash
flutter build web --release
```

#### Windows:

```bash
flutter build windows --release
```

## 📁 Struktur Project

```
lib/
├── app/
│   ├── modules/
│   │   └── home/              # Module halaman home
│   │       ├── bindings/      # Dependency injection
│   │       ├── controllers/   # Business logic
│   │       └── views/         # UI components
│   └── routes/
│       └── app_pages.dart     # Route definitions
├── bindings/
│   └── home_binding.dart      # Global bindings
├── models/
│   └── news_response.dart     # Data models
├── service/
│   └── news_service.dart      # API service layer
├── utils/
│   ├── app_colors.dart        # Color constants
│   └── constants.dart         # App constants
├── widgets/
│   ├── news_card.dart         # Reusable news card widget
│   └── news_detail.dart       # News detail widget
└── main.dart                  # Entry point
```

## 🎨 Screenshots

<!-- Tambahkan screenshot aplikasi Anda di sini -->

_Coming soon..._

## 🔧 Troubleshooting

### Error: "WebViewPlatform tidak diinisialisasi"

Pastikan Anda sudah mengimpor platform-specific WebView di `main.dart`:

```dart
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
```

### Error: "API_KEY tidak ditemukan"

Pastikan file `.env` berada di root project dan berisi API key yang valid.

### Error: "Failed to load news"

- Periksa koneksi internet
- Verifikasi API key masih valid
- Cek quota API di dashboard News API

## 📝 Catatan

- **API Limitation**: API gratis memiliki batasan 100 request/hari. Upgrade ke plan berbayar untuk unlimited requests.
- **Country Code**: Default negara adalah `us`. Ubah di `constants.dart` untuk negara lain.
- **App Name**: Nama aplikasi "Zone News" dapat diubah di `constants.dart`.

## 🤝 Kontribusi

Kontribusi selalu diterima! Silakan:

1. Fork repository
2. Buat branch fitur baru (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

## 📄 License

Project ini dilisensikan di bawah MIT License - lihat file LICENSE untuk detail.

## 👨‍💻 Developer

Dikembangkan dengan ❤️ menggunakan Flutter

---

**Note**: Jangan lupa untuk memberikan ⭐ jika project ini membantu Anda!
