# FlashlearnApp - Flutter

Este projeto trata-se da segunda atividade avaliativa da disciplina de Desenvolvimento Móvel, ministrada pelo professor André Endo (UFSCar). O objetivo é desenvolver um aplicativo de flashcards utilizando a tecnologia Flutter com o suporte da linguagem Dart, com integração a um backend desenvolvido em Java Spring JPA e persistência de dados em um banco de dados MySQL.

## Tecnologias Utilizadas

- *Interface*: Flutter com a linguagem Dart
- *Backend*: Java Spring com JPA
- *Banco de Dados*: MySQL
- *Padrões Arquiteturais*: MVVM (Model-View-ViewModel)
- *Integração com Banco de Dados*: Pacote DIO
- *Persistência Local no App*: via Pacote SharedPreferences

## Instruções para Rodar
## Backend
Link para o repositório do backend do projeto: https://github.com/vitorkasai/flash-learn-backend
### Tecnologias Necessárias
- Java 17
- Maven
- MySQL
  
1. Criar schema com o nome flashlearn.
2. Rodar script de criação das tabelas (script está no repositório).
3. Compilar o projeto com `mvn clean install`
4. Rodar projeto com `mvn spring-boot:run`

### Interface (Aplicativo)
1. Certifique-se de ter o Flutter SDK e o Dart instalados.
2. Abra o projeto no Android Studio.
3. Realize o build do aplicativo via IDE Android Studio para resolver as dependências, ou utilize o comando `flutter pub get`.
4. Rode o comando `flutter gen-l10n` para gerar as localizações da internacionalização dos textos.
5. Rode o arquivo main do projeto.

## Contribuições
- Vitor Kasai Tanoue, RA: 801904
- Karen Ketlyn Barcelos, RA: 799657
