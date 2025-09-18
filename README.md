[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/x--mPZ-x)
# CineList

No dia a dia, muitas pessoas passam mais tempo escolhendo o que assistir do que realmente assistindo. Plataformas de streaming oferecem milhares de opções, mas falta uma maneira simples de organizar filmes e séries de interesse, descobrir novidades e priorizar o que realmente importa.
Pensando nisso, nasceu o CineList — um aplicativo que ajuda o usuário a explorar conteúdos, filtrar por gêneros de preferência, organizar sua própria lista de interesse e acompanhar o que já foi assistido.

## 📋 Pré-requisitos

- Flutter SDK (^3.29.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android SDK / Xcode (for iOS development)

## 🛠️ Executar

1. Instalar dependências:

```bash
flutter pub get
```

2. Rodar a aplicação:

```bash
flutter run
```

## 📁 Estrutura do projeto

```
flutter_app/
├── android/            # Configs específicas do Android
├── ios/                # Configs Específicas de iOS
├── lib/
│   ├── core/
│   │   └── api/        # Classes de comunicação com API
│   │   └── enums/      # Enums
│   │   └── models/     # Modelos de dados
│   ├── presentation/   # UI
│   ├── routes/         # Definição das rotas da aplicação
│   ├── theme/          # Configuração de tema
│   ├── widgets/        # Componentes de UI reusáveis
│   └── main.dart
├── assets/             # assets (imagens, fontes, etc.)
├── pubspec.yaml        # Libs e dependências
└── README.md           # documentação

```
