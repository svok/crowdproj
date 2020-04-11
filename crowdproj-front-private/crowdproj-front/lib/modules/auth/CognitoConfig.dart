// Setup AWS User Pool Id & Client Id settings here:
import 'package:amazon_cognito_identity_dart/cognito.dart';

class CognitoConfig {
  static const awsUserPoolId = 'us-east-1_5emWoNX7C';
  static const awsClientId = '7v14t8gpccpaab9qn9rq9i1rit';

  static const identityPoolId = 'us-east-1:c3095362-32fd-4bc2-be8a-0e685848f821';

  // Setup endpoints here:
  static const region = 'us-east-1';
  static const endpoint = 'https://temedis.auth.us-east-1.amazoncognito.com/';

  static userPool(CognitoStorage storage) => CognitoUserPool(awsUserPoolId, awsClientId, storage: storage);
}

