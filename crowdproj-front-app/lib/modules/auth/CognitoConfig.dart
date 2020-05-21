// Setup AWS User Pool Id & Client Id settings here:
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crowdproj/CrowdprojConstants.dart';

class CognitoConfig {
  static const awsUserPoolId = CrowdprojConstants.awsUserPoolId;
  static const awsClientId = CrowdprojConstants.awsClientId;

  static const identityPoolId = CrowdprojConstants.identityPoolId;

  // Setup endpoints here:
  static const region = CrowdprojConstants.awsRegion;
  static const endpoint = CrowdprojConstants.awsCognitoEndpoint;

  static userPool(CognitoStorage storage) => CognitoUserPool(awsUserPoolId, awsClientId, storage: storage);
}

