<a href="https://github.com/gzaber/notes_app/actions"><img src="https://img.shields.io/github/actions/workflow/status/gzaber/notes_app/main.yaml" alt="build"></a>
<a href="https://codecov.io/gh/gzaber/notes_app"><img src="https://codecov.io/gh/gzaber/notes_app/branch/master/graph/badge.svg" alt="codecov"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/gzaber/notes_app" alt="license MIT"></a>

# notes_app

A simple notes app based on following concept:  
https://dribbble.com/shots/11875872-A-simple-and-lightweight-note-app

## Table of contents

- [Screenshots](#screenshots)
- [Features](#features)
- [Packages used](#packages-used)
- [Setup](#setup)
- [Test](#test)
- [Run](#run)

## Screenshots

[<img alt="Notes overview page" width="200px" src=".screenshots/notes_overview.png" />](.screenshots/notes_overview.png)
[<img alt="Note page" width="200px" src=".screenshots/note.png" />](.screenshots/note.png)
[<img alt="Create note" width="200px" src=".screenshots/manage_note_create.png" />](.screenshots/manage_note_create.png)
[<img alt="Update note" width="200px" src=".screenshots/manage_note_update.png" />](.screenshots/manage_note_update.png)
[<img alt="Search note" width="200px" src=".screenshots/search.png" />](.screenshots/search.png)
[<img alt="Delete note" width="200px" src=".screenshots/delete.png" />](.screenshots/delete.png)
[<img alt="Empty title error" width="200px" src=".screenshots/manage_note_error.png" />](.screenshots/manage_note_error.png)

## Features

- create, update, delete note
- search notes by title
- supported locales: en, pl

## Packages used

- equatable
- flutter_bloc
- flutter_staggered_grid_view
- intl
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

For local packages run above command in package root directory.

## Run

Run the application using your IDE or using the following command:

```
$ flutter run
```
