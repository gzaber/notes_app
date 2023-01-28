<a href="https://github.com/gzaber/notes_app/actions"><img src="https://img.shields.io/github/actions/workflow/status/gzaber/notes_app/main.yaml" alt="build"></a>
<a href="https://codecov.io/gh/gzaber/notes_app"><img src="https://codecov.io/gh/gzaber/notes_app/branch/master/graph/badge.svg" alt="codecov"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/gzaber/notes_app" alt="license MIT"></a>

# notes_app

A simple notes app based on the following concept:  
https://dribbble.com/shots/11875872-A-simple-and-lightweight-note-app

## Table of contents

- [Screenshots](#screenshots)
- [Features](#features)
- [Packages used](#packages-used)
- [Setup](#setup)
- [Test](#test)
- [Run](#run)

## Screenshots

[<img alt="notes overview page" width="250px" src=".screenshots/notes_overview_page.png" />](.screenshots/notes_overview_page.png)
&nbsp;
[<img alt="note page" width="250px" src=".screenshots/note_page.png" />](.screenshots/note_page.png)
&nbsp;
[<img alt="search notes" width="250px" src=".screenshots/search_notes.png" />](.screenshots/search_notes.png)

[<img alt="notes overview recording" width="250px" src=".screenshots/recording1.gif" />](.screenshots/recording1.gif)
&nbsp;
[<img alt="update note recording" width="250px" src=".screenshots/recording2.gif" />](.screenshots/recording2.gif)
&nbsp;
[<img alt="search notes recording" width="250px" src=".screenshots/recording3.gif" />](.screenshots/recording3.gif)

## Features

- create, update, delete note
- search notes by title
- supported locales: en, pl

## Packages used

- bloc
- json_annotation
- sqflite
- uuid

## Setup

Clone or download this repository.  
Use the following command to install all the dependencies:

```
$ flutter pub get
```

## Test

Run the tests using your IDE or using the following command:

```
$ flutter test --coverage
```

For local Flutter packages run the above command in the package root directory.  
For local Dart packages run the following commands in the package root directory:

```
$ dart pub global activate coverage
$ dart pub global run coverage:test_with_coverage
```

## Run

Run the application using your IDE or using the following command:

```
$ flutter run
```
