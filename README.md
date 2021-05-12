# SMUS - Flutter App Architecture

<p align="center">
  <img src="https://github.com/eli1stark/smus/blob/master/readme_assets/logo.svg" height="280">
</p>
<p align="center">
    <img src="https://github.com/eli1stark/smus/blob/master/readme_assets/logo_desc.svg" height="80">
</p>

# Sample App

**Hacker News App** which is using the following [API](https://hackernews.api-docs.io/)

# Motivation

The main purpose of this project is to consolidate all ideas in the Flutter Community about architectures and create an universal architecture for the Flutter App.

Flutter is easy to learn and develop with, but when project is getting bigger it's becoming very verbose and hard to maintain.

It's very easy to make bad structured and unmaintainable applications.

Solution is obvious - create set of rules that flutter developers will follow while creating their apps.

If we have already defined architecture and rules it's very easy to onboard new developers or switch between different projects since almost all patterns are the same. The only difference is small implementation details but the skeleton is still the same.

My proposal is SMUS approach but I'm open for other suggestions. New ideas and contributions are highly welcomed. 

If you have any questions just create an issue and we'll discuss it.

# Architecture layers

## Model

It's just a pure model class.

Model should not depend on any other layer except for itself. 

All other layers are dependent on Model.

All models must be immutable to avoid some unexpected change of the value in the future (Rule #1).

When you start to design your app the first thing you need to do is to define the business rules aka models.

Sooner or later you will face the following problems in your model layer:

1. `copyWith()` functionality and deep copy.
2. Support assigning a value to null in `copyWith()`.
3. `==` operator of 2 instances, since Dart comparing objects by pointer and not the value.
4. Override of `toString()`.
5. Proper immutability of your models.

All of the problems above and even more are solved by [freezed package](https://github.com/rrousselGit/freezed) from Remi.

We will use it to reduce amount of boilerplate code and keep our codebase clean.

If you don't like freezed or any other third-party solution you can easily solve this problems by yourself, except for deep copy I found it quite difficult to implement.

So, we have 2 templates:

1. freezed case (*fclass* snippet):

    ```dart
    @freezed
    class Model with _$Model{
      const factory Model() = _Model;
    }
    ```

    In this case all needed features are already implemented. Freezed classes are immutable by default.

2. by ourselves (*iclass* snippet):

    ```dart
    @immutable
    class Model {
      const Model();
    }
    ```

    In this case each feature needs to be implemented separately. Life savior is [Data Class Generator](https://marketplace.visualstudio.com/items?itemName=BendixMa.dart-data-class-generator) plugin for VSCode.

Notice that we are using `const` constructors everywhere where possible (Rule #2).

And all parameters of the model must be `final` (Rule #3), derived from Rule #1.

**Which template is better to use?**

The rule of thumb: Start from `immutable` class and then if you need additional features use `freezed` class. **YAGNI**

## Source

Source is divided into 3 sublayers.

### Service

Service is responsible for delivering data from API to our app and vice versa.

From API It receives Raw Data as `Map<String, dynamic>` which is used inside Repository.

From Repository it receives `Map<String, dynamic>` and sends it to the API.

Service is used only inside a Repository.

All networking is done by `dio` package.

### DTO (Data Transfer Object)

Responsibility of DTO is to perform 4 operations:

1. `toJson()` - converts `DTO` to `Map<String, dynamic>` format.
2. `fromJson()` - converts `Map<String, dynamic>` to `DTO`.
3. `toModel()` - converts `DTO` to `Model`.
4. `fromModel()` - converts `Model` to `DTO`.

DTO is used only inside a Repository.

All serialization is done by `json_serializable` package.

### Repository

Repository is just an intermediary between our state and services.

Converts Raw Data `fromJson()` `toModel()` and `fromModel()` `toJson()`.

Here we are also writing try-catch blocks. 

We can also perform some finishing touches on the data like sorting, parsing and so on.

## State

This layer is responsible for state management in the app. It directly works with Repository, Model and UI layer.

Since I want this architecture to be universal implementation details of this layer may differ and will depend on state management approach you will choose.

I will show you my approach using Riverpod.

State is divided into 3 sublayers:

1. **Notifiers** - managing actual state of the app by using `StateNotifier` from Riverpod.
2. **Providers** - providing notifiers and other data.
3. **Repositories** - providing repositories (from source layer), also can perform some operations with them. Repositories can be either `FutureProvider` or `StreamProvider` .

#### Rules:

1. We are not using `ChangeNotifier` because it's not immutable.

#### Conventions:

```dart
final homeProvider = Provider<int>((ref) {
  return 1;
});
```

In the specific example above you can think that there is no point to use short naming but when our application grows we need to name our providers as much descriptive as we can and sometimes the name of variables can become too long which is not good for eye and usage, like this: `deletedInformationOfPostStateNotifierProvider`.
So, the suggestion is to use short convention naming for our state layer:
- **Repositories:**
    - **Frep** = `FutureRepository`
    - **Srep** = `StreamRepository`
- **Providers:**
    - **Pod** = `Provider`
    - **Fpod** = `FutureProvider`
    - **Spod** = `StreamProvider`
    - **Stpod** = `StateProvider`
    - **Notipod** = `StateNotifierProvider`
- **Notifier** = `StateNotifier`, we are dropping "State" part since we aren't using `ChangeNotifier` and `ValueNotifier`.

## UI

This layer can get messy really fast. So, here we need to be very careful.

But I have solution how to deal with organization of our widgets.

Everyone knows that all widgets in flutter app are living inside a tree. If you didn't know this just open a DevTool.

So, why don't we just follow tree-like organizational structure for our widgets the same way they are structured under the hood of framework.

We will also use power of Flutter's composition.

**Example:**

<details>
  <summary>Code</summary>
    
```dart
// Path ui/my_screen.dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyScreenText(),
        MyScreenButton(),
        MyScreenDescription(),
      ],
    );
  }
}

// Path ui/components/my_screen_text.dart
class MyScreenText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // ... some code here
  }
}

// Path ui/components/my_screen_button.dart
class MyScreenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // ... some code here
  }
}

// Path ui/components/my_screen_description/my_screen_description.dart
class MyScreenDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyScreenDescriptionImage(),
        MyScreenDesciptionCard(),
      ],
    );
  }
}

// Path ui/components/my_screen_description/components/my_screen_description_image.dart
class MyScreenDescriptionImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // ... some code here
  }
}

// Path ui/components/my_screen_description/components/my_screen_description_card.dart
class MyScreenDesciptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // ... some code here
  }
}

//! The name of the widgets can be much shorter and descriptive, I used long names for illustration purposes
```
    
</details>

<details>
  <summary>Folder structure</summary>
    
    .
    ├── ...
    ├── ui                      
    │   ├── components
    │   │   ├── my_screen_description 
    |   |   |   ├── components
    |   |   |   |   ├── my_screen_description_card.dart
    |   |   |   |   └── my_screen_description_image.dart
    |   |   |   └── my_screen_description.dart
    │   │   ├── my_screen_button.dart
    |   |   └── my_screen_text.dart
    │   └── my_screen.dart        
    └── ...

</details>

Now imagine that we need to use `MyScreenDesciptionCard()` also in the `MyScreen()`.

By having tree-like structure we can easily refactor our code, so we can lift `MyScreenDesciptionCard()` by one level up.

Since the level of the widget is increased we need to give it a new name and rename the file because the previous name doesn't make sense anymore.

The good name will be `MyScreenCard()` since it placed on the same level as other widgets of `MyScreen()`.

So, we have:

<details>
  <summary>Code</summary>
    
```dart
// Path ui/my_screen.dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyScreenText(),
        MyScreenButton(),
        MyScreenDescription(),
      ],
    );
  }
}

// Path ui/components/my_screen_text.dart
class MyScreenText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // ... some code here
  }
}

// Path ui/components/my_screen_button.dart
class MyScreenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // ... some code here
  }
}

// Path ui/components/my_screen_card.dart
class MyScreenCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // ... some code here
  }
}

// Path ui/components/my_screen_description/my_screen_description.dart
class MyScreenDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyScreenDescriptionImage(),
      ],
    );
  }
}

// Path ui/components/my_screen_description/components/my_screen_description_image.dart
class MyScreenDescriptionImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // ... some code here
  }
}

//! The name of the widgets can be much shorter and descriptive, I used long names for illustration purposes
```
   
</details>

<details>
  <summary>Folder structure</summary>
    
    .
    ├── ...
    ├── ui                      
    │   ├── components
    │   │   ├── my_screen_description 
    |   |   |   ├── components
    |   |   |   |   └── my_screen_description_image.dart
    |   |   |   └── my_screen_description.dart
    │   │   ├── my_screen_button.dart
    |   |   ├── my_screen_card.dart
    |   |   └── my_screen_text.dart
    │   └── my_screen.dart        
    └── ...

</details>

# Illustrations

- **Dependency illustration**
      
   <img src="https://github.com/eli1stark/smus/blob/master/readme_assets/smus_dependency.svg" width="320">

   Arrows illustrate dependency. For example, UI is dependent on the State and Model. 

- **Data flows**

    We have 2 general bidirectional flows in the application

    - **User → API → User (External flow)**
        
      <img src="https://github.com/eli1stark/smus/blob/master/readme_assets/smus_flow1.svg" height="300">

    - **User → Model → User (Internal flow)**

      <img src="https://github.com/eli1stark/smus/blob/master/readme_assets/smus_flow2.svg" height="140">


# Folder Structure Convention

- Folder Structure of a single feature
    
        .
        ├── ...
        ├── feature                      
        │   ├── model
        |   |   ├── some_model.dart
        |   |   └── some_other_model.dart
        │   ├── source
        |   |   ├── dto
        |   |   |   ├── some_dto.dart
        |   |   |   └── some_other_dto.dart  
        |   |   ├── repository
        |   |   |   ├── repositories
        |   |   |   |   ├── some_repository.dart
        |   |   |   |   └── some_other_repository.dart  
        |   |   |   └── feature_repository.dart  # acts like facade for other repositories
        |   |   └── service
        |   |       ├── services
        |   |       |   ├── some_service.dart
        |   |       |   └── some_other_service.dart  
        |   |       └── feature_service.dart  # acts like facade for other services
        |   ├── state
        |   |   ├── notifiers
        |   |   |   ├── some_notifier
        |   |   |   |   ├── state # can be optional if you are using model
        |   |   |   |   |   └── some_notifier_state.dart
        |   |   |   |   ├── union # optional, use only if you need 
        |   |   |   |   |   └── some_notifier_union.dart
        |   |   |   |   └── some_notifier.dart 
        |   |   |   └── some_other_notifier.dart  
        |   |   ├── providers
        |   |   |   ├── some_fpod.dart 
        |   |   |   ├── some_notipod.dart 
        |   |   |   ├── some_pod.dart 
        |   |   |   ├── some_spod.dart 
        |   |   |   └── some_stpod.dart  
        |   |   └── repositories # under question (see below)
        |   |       ├── some_frep.dart 
        |   |       └── some_srep.dart 
        |   └── ui
        |       ├── components
        |       |   ├── some_complex_component
        |       |   |   ├── components
        |       |   |   |   ├── some_part.dart
        |       |   |   |   └── some_other_part.dart
        |       |   |   └── some_complex_component.dart
        |       |   ├── some_button.dart
        |       |   └── some_text.dart
        |       └── feature.dart  
        └── ...
        

    <details>
     <summary>VSCode illustration</summary>
    
     ![illustration](https://github.com/eli1stark/smus/blob/master/readme_assets/feature_folder_structure.png)

    </details>


    * I listed all possible providers and repositories for illustration. You don't have to use all of them if you don't need.
    * All endings in the `model`, `source` and `state` layers are conventions. (e.g. `_model`, `_dto`, `_fpod` and so on.)
    * Naming of core folders is constant (e.g. `ui`, `source`, `dto`, `service`, `services`, `notifiers`(in case you are using riverpod) and so on.)
    * In the `ui` layer conventions are following:
        1. Every feature and subfeature must have folder called `components` and dart file named by feature's name.
           In our case we have subfeature(complex component) called "some_complex_component" which has folder `components` and dart file named by itself.
           Single dart file is considered as component. (e.g. `some_part.dart`)
        2. Naming of components is up to you.
    * There is some ambiguity between repositories and future/stream providers. 
      Repositories are future/stream providers that are working with repositories from our source layer.
      But if we think about it almost in 90% of cases the only reaseon why we need to use future/stream providers is to access repoistory from the source layer.
      So, if that's the case do we need to complicate things and create another sublayer for those kind of things?
      Probably it will better if we'll use just future/stream providers (aka fpod and spod) for this kind of things.
      So at the end we have just 2 sublayers: notifiers and providers.

# Rules

1. All models must be `immutable`.
2. Always use const constructors where possible.
3. All parameters must be `final`.

## Naming conventions

Naming is very important part of every architecture.

It needs to be descriptive and useful through our development process.

In the following example assume that we are making some feature which is called "Home".

```dart
// Source
class HomeDto {}
class HomeRepository {}
class HomeService {}

// Model
class HomeModel {}

// UI
class Home extends StatelessWidget {}

// We won't use short naming for Source, Model, and UI because this will become very tedious in the future
// We need our code to be maximum descriptive, so, the only compromise we made is naming of our state layer

// State
class HomeNotifier extends StateNotifier<HomeModel> {}
// Naming of repositories and providers discussed in the "state" part of the docs.
```

The naming above is strict and shouldn't be violated.

### General

1. Name of the **file** must have **snake_case**
2. Name of the **object** must have **camelCase**


# Linting

For linting we are using [lint](https://pub.dev/packages/lint) package with our own modifications.

See  `analysis_options.yaml` file.

# Tests

*In progress*

# Gitignore

It's very important to construct a good `.gitignore` file since the default one is lacking some files.

This will help to avoid merge conflicts in the team and keep codebase more organized.

See `.gitignore` file.

# Philosophies

1. "Keep it simple" - **KIS**
2. "Don't repeat yourself" - **DRY**
3. "You are not gonna need it" - **YAGNI**
4. We don’t make things easy to do, we make things easy to understand.  [5 - Bill Kennedy]
5. You write things in the concrete first, then you ask: "Does that require an abstraction layer?” [5]
6. Don't do something for the sake of doing it. [5]
7. You shouldn’t be writing code for yourself. You should be writing code for the next person that will maintain it. [5]
8. Make it work, make it right, make it fast, make it testable. (4 steps of refactoring).
9. Don’t make something complex until you absolutely have no choice. [5]
10. You should be writing code that you need today, not tomorrow. [5]
11. The only way to go fast is to go well. [4 - Uncle Bob]
12. The function should do one thing. [4]
13. Architecture is not about making decisions early, it's about making decisions late. [4]
14. Write tests for every bit of the code. [4]
15. Don't make tests coupled to the system. [4]

# More

## Favorite packages

### Model

1. [freezed](https://pub.dev/packages/freezed) - code generation for immutable classes

### Source

1. [dio](https://pub.dev/packages/dio) - http client
2. [json_serializable](https://pub.dev/packages/json_serializable) - dart build system builders for handling JSON

### State

1. [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) - simple way to access state from anywhere
2. [hooks_riverpod](https://pub.dev/packages/hooks_riverpod) - riverpod with hooks
3. [flutter_hooks](https://pub.dev/packages/flutter_hooks) - additional hooks' functionality

### UI

1. [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) - regular icons
2. [google_fonts](https://pub.dev/packages/google_fonts) - 1100+ fonts from Google (Internet access)
3. [device_preview](https://pub.dev/packages/device_preview) - how your app looks and performs on other devices
4. [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) - adapting screen and font size

## VSCode snippets

Snippets are available in the VSCode plugin - [SMUS Snippets](https://marketplace.visualstudio.com/items?itemName=EliStark.smus-snippets).

### Model

1. `iClass` - creates immutable class
2. `fClass` - creates freezed class
3. `fpart` - creates freezed part

### Source

1. `fromJson` - creates `fromJson()` factory for json_serializable
2. `toJson` - creates `toJson()` function for json_serializable
3. `fromModel` - creates `fromModel()` factory
4. `toModel` - creates `toModel()` function
5. `dto` - creates DTO class with all boilerplate needed - imports, parts, `fromJson()`, `toJson()`, `fromModel()`, `toModel()`.
6. `repo` - creates repository function with all needed boilerplate
7. `gpart` - creates generated part for `json_serializable`

### State

1. `pod` - creates plain Provider
2. `fpod` - creates Future Provider
3. `spod` - creates Stream Provider
4. `stpod` - creates State Provider
5. `notipod` - creates State Notifier Provider
6. `frep` - creates Future Repository
7. `srep` - creates Stream Repository
8. `notifier` -  create State Notifier class

## VSCode themes

1. If you want the same folder layout as in the screenshots, install [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme) plugin and write the following code inside your VSCode's `settings.json` file:

    ```dart
    "material-icon-theme.folders.associations": {
        "ui": "layout",
        "utilities": "utils",
        "source": "server",
        "dto": "mappings",
        "repository": "pipe",
        "repositories": "pipe",
        "notifiers": "redux-store",
        "state": "react-components",
    },
    ```
   
# Credits
1. This architecture is inspired by [DDD](https://www.youtube.com/watch?v=pMuiVlnGqjk&ab_channel=Domain-DrivenDesignEurope) created by Eric Evans which was introduced to me by [ResoCoder](https://www.youtube.com/channel/UCSIvrn68cUk8CS8MbtBmBkA) in his awesome tut.
2. It was very useful too see [BLoC](https://bloclibrary.dev/#/) architecture by [Felix Angelov](https://github.com/felangel) that was introduced to me by [Flutterly](https://www.youtube.com/channel/UC5PYcSe3to4mtm3SPCUmjvw) in his amazing [video series: "BLoC From Zero to Hero"](https://www.youtube.com/watch?v=THCkkQ-V1-8&t=3727s&ab_channel=Flutterly).
3. Huge thanks to Remi Rousselet's for creating such great packages like [provider](https://pub.dev/packages/provider), [riverpod](https://pub.dev/packages/riverpod), [freezed](https://pub.dev/packages/freezed) and [flutter_hooks](https://pub.dev/packages/flutter_hooks).
4. Some principles and rules were borrowed from [Uncle Bob's](http://cleancoder.com/products) talk ["Clean Code"](https://www.youtube.com/watch?v=7EmboKQH8lM&ab_channel=UnityCoin).
5. Thanks to [Bill Kennedy](https://twitter.com/goinggodotnet) for his talk at the [Go Time Podcast #172 (Design Philosophy)](https://changelog.com/gotime/172).
7. Logo made by [Freepik](https://www.freepik.com) from [www.flaticon.com](https://www.flaticon.com/)
