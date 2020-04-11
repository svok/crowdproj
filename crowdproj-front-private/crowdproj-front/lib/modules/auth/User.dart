import 'dart:convert';

import 'package:amazon_cognito_identity_dart/cognito.dart';

class User {
  String id;
  String email;
  bool emailVerified;
  String name;
  String givenName;
  String familyName;
  String password;
  bool confirmed = false;
  bool hasAccess = false;

  User({
    this.id,
    this.email,
    this.emailVerified,
    this.name,
    this.givenName,
    this.familyName,
    this.confirmed,
    this.hasAccess,
  });

  // Decode user from Cognito User Attributes
  factory User.fromUserAttributes(List<CognitoUserAttribute> attributes) {
    final user = User();
    attributes.forEach((attribute) {
      switch (attribute.getName()) {
        case _attributeNameId:
          user.id = attribute.getValue();
          break;
        case _attributeNameEmail:
          user.email = _getAttrVal(attribute);
          break;
        case _attributeNameEmailVerified:
          user.emailVerified = attribute.getValue() == "true";
          break;
        case _attributeNameName:
          user.name = _getAttrVal(attribute);
          break;
        case _attributeNameGivenName:
          user.givenName = _getAttrVal(attribute);
          break;
        case _attributeNameFamilyName:
          user.familyName = _getAttrVal(attribute);
          break;
      }
    });
    return user;
  }

  static _getAttrVal(CognitoUserAttribute attribute) {
    return utf8.decode(attribute.getValue().codeUnits);
  }

  List<CognitoUserAttribute> getCognitoAttributes() => [
        CognitoUserAttribute(name: _attributeNameEmail, value: email),
        CognitoUserAttribute(name: _attributeNameName, value: name),
        CognitoUserAttribute(name: _attributeNameFamilyName, value: familyName),
        CognitoUserAttribute(name: _attributeNameGivenName, value: givenName),
      ];

  static const _attributeNameId = 'sub';
  static const _attributeNameEmail = 'email';
  static const _attributeNameEmailVerified = 'email_verified';
  static const _attributeNameName = 'name';
  static const _attributeNameGivenName = 'given_name';
  static const _attributeNameFamilyName = 'family_name';
}
