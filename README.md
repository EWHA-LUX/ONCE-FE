# ONCE-FE
> Once : 카드 다보유자를 위한 결제 전 최대 할인 카드 추천 AI 챗봇 서비스

## 🛠️ Tech Stack
- Flutter 3.7.0
- Dart 2.19.0
- Firebase Cloud Messaging
- GoogleMap API

## ☁️ How to run
1. Clone project
```bash
$ git clone https://github.com/EWHA-LUX/ONCE-FE.git
```
     
2. Set `local.properties`
```yaml
googlemap.api.key=(YOUR_API_KEY)
```

3. Install dependencies
```bash
$ flutter pub get
```

4. Run flutter
```bash
$ flutter run lib/main.dart --dart-define=BASE_URL=https://once-app.site/ 
``` 

## 📁 Directory Structure
```
ONCE-FE
│
├── assets
│   └── fonts
│   └── images
│  
│  (...) 
│
├── lib
│   └── src
│   │   ├── screens
│   │   │   └── login
│   │   │   │   └── login.dart
│   │   │   │   └── (...)  
│   │   │   │
│   │   │   └── home 
│   │   │   │   └── home.dart
│   │   │   │   └── (...)   
│   │   │   │
│   │   │   └── mywallet 
│   │   │   │   └── mywallet.dart
│   │   │   │   └── (...)
│   │   │   │
│   │   │   └── mypage 
│   │   │       └── mypage.dart
│   │   │       └── (...)
│   │   │   
│   │   ├── components
│   │   │   └── (components 내부 파일 및 폴더)
│   │   │
│   │   └── app.dart
│   │
│   └── main.dart
│   └── style.dart
```
## 📽️ Once Demo

[![Youtube Badge](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=YouTube&logoColor=white&link=https://youtu.be/UJgmluR4QpY)](https://youtu.be/UJgmluR4QpY)

## 👩🏻‍💻 Front-End Contributors

| Jimin Yu                    | Haewon Lee                          | 
| --------------------------------- | --------------------------------- | 
| ![](https://github.com/jiminnee.png) | ![](https://github.com/haewonny.png) | 
| <p align="center"><a href="https://github.com/jiminnee">@jiminnee</a></p> | <p align="center"><a href="https://github.com/haewonny">@Haewonny</a></p> | 

<img src="https://github.com/EWHA-LUX/ONCE-FE/assets/94354545/2fea2faa-7eaf-4c54-8aab-156601c47f79" border="0" width="1000px" />


