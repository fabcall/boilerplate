// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStore, Store {
  final _$_userDidFinishOnboardingAtom =
      Atom(name: '_SettingsStore._userDidFinishOnboarding');

  @override
  bool get _userDidFinishOnboarding {
    _$_userDidFinishOnboardingAtom.reportRead();
    return super._userDidFinishOnboarding;
  }

  @override
  set _userDidFinishOnboarding(bool value) {
    _$_userDidFinishOnboardingAtom
        .reportWrite(value, super._userDidFinishOnboarding, () {
      super._userDidFinishOnboarding = value;
    });
  }

  final _$setUserDidFinishOnboardingAsyncAction =
      AsyncAction('_SettingsStore.setUserDidFinishOnboarding');

  @override
  Future<dynamic> setUserDidFinishOnboarding(bool value) {
    return _$setUserDidFinishOnboardingAsyncAction
        .run(() => super.setUserDidFinishOnboarding(value));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
