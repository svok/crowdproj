import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crowdproj/modules/auth/CognitoConfig.dart';

import 'User.dart';

class AuthService {

  AuthService(this._userPool);

  final CognitoUserPool _userPool;
  CognitoUser _cognitoUser;
  User _currentUser;
  CognitoUserSession _session;
  CognitoCredentials credentials;

  User get currentUser => _currentUser;

  /// Initiate user session from local storage if present
  Future<void> init() async {
    _cognitoUser = await _userPool.getCurrentUser();
    if (_cognitoUser == null) {
      return false;
    }
    _session = await _cognitoUser.getSession();
    _currentUser = await getCurrentUser();
  }

  /// Get existing user from session with his/her attributes
  Future<User> getCurrentUser() async {
    if (_cognitoUser == null || _session == null) {
      print("_cognitoUser == null || _session == null");
      _currentUser = null;
      return null;
    }
    if (!_session.isValid()) {
      _currentUser = null;
      print("!_session.isValid()");
      return null;
    }

    final attributes = await _cognitoUser.getUserAttributes();
    if (attributes == null) {
      _currentUser = null;
      print("attributes == null");
      return null;
    }
    final user = new User.fromUserAttributes(attributes);
    user.hasAccess = true;
    _currentUser = user;
    print("user is OK");
    return user;
  }

  /// Retrieve user credentials -- for use with other AWS services
  Future<CognitoCredentials> getCredentials() async {
    if (_cognitoUser == null || _session == null) {
      return null;
    }
    credentials = new CognitoCredentials(CognitoConfig.identityPoolId, _userPool);
    await credentials.getAwsCredentials(_session.getIdToken().getJwtToken());
    return credentials;
  }

  /// Login user
  Future<User> login(String email, String password) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);

    final authDetails = new AuthenticationDetails(
      username: email,
      password: password,
    );

    bool isConfirmed;
    try {
      _session = await _cognitoUser.authenticateUser(authDetails);
      isConfirmed = true;
    } on CognitoClientException catch (e) {
      _currentUser = null;
      if (e.code == 'UserNotConfirmedException') {
        return User(confirmed: false, hasAccess: false);
      } else {
        throw e;
      }
    }

    if (!_session.isValid()) {
      _currentUser = null;
      return null;
    }

    final attributes = await _cognitoUser.getUserAttributes();
    final user = new User.fromUserAttributes(attributes);
    user.confirmed = isConfirmed;
    user.hasAccess = true;

    _currentUser = user;
    return user;
  }

  /// Confirm user's account with confirmation code sent to email
  Future<bool> confirmAccount(String email, String confirmationCode) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);

    return await _cognitoUser.confirmRegistration(confirmationCode);
  }

  /// Resend confirmation code to user's email
  Future<void> resendConfirmationCode(String email) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);
    await _cognitoUser.resendConfirmationCode();
  }

  /// Check if user's current session is valid
  bool isAuthenticated() {
    if (_cognitoUser == null || _session == null) {
      return false;
    }
    return _session.isValid();
  }

  /// Sign up new user
  Future<User> signUp(String email, String password, String name) async {
    CognitoUserPoolData data;
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
    ];
    data =
    await _userPool.signUp(email, password, userAttributes: userAttributes);

    final user = new User();
    user.email = email;
    user.name = name;
    user.confirmed = data.userConfirmed;
    if (user.confirmed) {
      _currentUser = user;
    } else {
      _currentUser = null;
    }

    return user;
  }

  Future<void> signOut() async {
    if (credentials != null) {
      await credentials.resetAwsCredentials();
    }
    if (_cognitoUser != null) {
      await _cognitoUser.signOut();
    }

    print("User is logged out");
    _currentUser = null;
    _cognitoUser = null;
  }

  Future<void> updateUser(User user) async {
    final cognitoUser = _cognitoUser;
    if (cognitoUser == null) return;

    final newAttributes = user.getCognitoAttributes();
    await cognitoUser.updateAttributes(newAttributes);
  }

}
