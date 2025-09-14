# RickDex - Rick and Morty App

![GitHub repo size](https://img.shields.io/github/repo-size/devrenata/rickdex?style=for-the-badge)
![GitHub language count](https://img.shields.io/github/languages/count/devrenata/rickdex?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/devrenata/rickdex?style=for-the-badge)
![Bitbucket open pull requests](https://img.shields.io/bitbucket/pr-raw/devrenata/rickdex?style=for-the-badge)

<img src="docs/banner/rick-banner.png" alt="Banner de Rick and Morty">

Um aplicativo Flutter que consome a API pública do Rick and Morty para explorar personagens da série.
Construído com arquitetura MVVM, foco em boas práticas e organização de código.

## Screenshots

<p align="left">
  <img src="docs/screenshots/characters-page.jpeg" width="20%"/>
  <img src="docs/screenshots/favorites-page.jpeg" width="20%"/>
  <img src="docs/screenshots/rick-details.jpeg" width="20%"/>
</p>
<p align="left">
  <img src="docs/screenshots/morty-details.jpeg" width="20%"/>
  <img src="docs/screenshots/menu-drawer.jpeg" width="20%"/>
  <img src="docs/screenshots/empty-favorites.jpeg" width="20%"/>
</p>

## Funcionalidades

- [x] Listagem de personagens com paginação infinita;
- [x] Pull-to-Refresh para atualização da lista de personagens;
- [x] Tratamento de erros de rede e locais;
- [x] Testes unitários e de integração;
- [x] Ver detalhes completos do personagem;
- [x] Favoritar e desfavoritar personagens;
- [x] Persistência local de favoritos;
- [x] Interface responsiva;

## Arquitetura

O projeto utiliza a arquitetura **MVVM (Model-View-ViewModel** e **Change Notifier** para gerenciamento de estado. Essa escolha garante:
- Separação clara de responsabilidades;
- Facilidade de manutenção e testes;
- Escabilidade para novas features;

### Visão geral:

```mermaid
flowchart LR
    UI[UI / View] <--> VM[ViewModel]
    VM <--> Repository
    Repository <--> DataSource[(API / Local Database)]
```
### Estrutura de pastas:

```
lib/
├── main.dart
└── src            # código fonte do app
  ├── core/        # infraestrutura (rotas, injeção de dependências, excessões)
  ├── models/      # modelo de dados (entidades, dtos e repositórios)
  └── ui/          # telas, gerenciamento de estado, widgets e temas
```

## Tecnologias utilizadas:
- Flutter / Dart;
- Provider;
- GoRouter;
- Hive;
- Mocktail;

## Como executar

1. **Clone o repositório**
```bash
git clone https://github.com/devRenata/RickDex.git
cd RickDex
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**
```bash
flutter run
```
