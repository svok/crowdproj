// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  static m0(faultyEmail) => "Email format is invalid: ${faultyEmail}";

  static m1(userName) => "Sign out: ${userName}";

  static m2(description) => "Sorry. An error has occured. The error description: ${description}";

  static m3(code) => "Error: ${code}";

  static m4(description) => "Sorry. Unknown error has occured. The error description: ${description}";

  static m5(field, validationNameMinLengh, length) => "The field for ${field} must be at least ${validationNameMinLengh} symbols long, while currently it\'s size is just ${length} symbols";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "AuthLocalizations_emailError" : m0,
    "AuthLocalizations_signoutFor" : m1,
    "AuthLocalizations_title" : MessageLookupByLibrary.simpleMessage("Authentication"),
    "AuthLocalizations_titleConfirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "AuthLocalizations_titleLogin" : MessageLookupByLibrary.simpleMessage("Sign In"),
    "AuthLocalizations_titleRegister" : MessageLookupByLibrary.simpleMessage("Sign Up"),
    "AuthLocalizations_titleUpdate" : MessageLookupByLibrary.simpleMessage("Update Account"),
    "ErrorLocalizations_error403" : MessageLookupByLibrary.simpleMessage("Sorry. Access to the page requested is restricted."),
    "ErrorLocalizations_error404" : MessageLookupByLibrary.simpleMessage("Sorry. The page you are loogin for is not found here"),
    "ErrorLocalizations_errorWithoutCode" : m2,
    "ErrorLocalizations_labelErrorDescription" : MessageLookupByLibrary.simpleMessage("Error description"),
    "ErrorLocalizations_labelFailedPage" : MessageLookupByLibrary.simpleMessage("Failed page"),
    "ErrorLocalizations_titleErrorCoded" : m3,
    "ErrorLocalizations_titleErrorUncoded" : MessageLookupByLibrary.simpleMessage("Error"),
    "ErrorLocalizations_unknownError" : m4,
    "HomeLocalizations_loading" : MessageLookupByLibrary.simpleMessage("Loading..."),
    "HomeLocalizations_title" : MessageLookupByLibrary.simpleMessage("Hello World"),
    "HomeLocalizations_titleAbout" : MessageLookupByLibrary.simpleMessage("About"),
    "PromoLocalizations_title" : MessageLookupByLibrary.simpleMessage("Promo World"),
    "TeamsLocalizations_errorTextFieldLength" : m5,
    "TeamsLocalizations_hintName" : MessageLookupByLibrary.simpleMessage("New Yourk Wolves Byke Den"),
    "TeamsLocalizations_hintStatus" : MessageLookupByLibrary.simpleMessage("Active"),
    "TeamsLocalizations_hintSummary" : MessageLookupByLibrary.simpleMessage("In our team we are making fun, enjoy bikes, high speed and freedom"),
    "TeamsLocalizations_labelApplyTeam" : MessageLookupByLibrary.simpleMessage("Apply"),
    "TeamsLocalizations_labelDescription" : MessageLookupByLibrary.simpleMessage("Team Description"),
    "TeamsLocalizations_labelJoinTeam" : MessageLookupByLibrary.simpleMessage("Join"),
    "TeamsLocalizations_labelJoinabilityMember" : MessageLookupByLibrary.simpleMessage("Member"),
    "TeamsLocalizations_labelJoinabilityOwner" : MessageLookupByLibrary.simpleMessage("Owner"),
    "TeamsLocalizations_labelJoinabilityUser" : MessageLookupByLibrary.simpleMessage("Not required"),
    "TeamsLocalizations_labelLeaveTeam" : MessageLookupByLibrary.simpleMessage("Leave"),
    "TeamsLocalizations_labelName" : MessageLookupByLibrary.simpleMessage("Team Name"),
    "TeamsLocalizations_labelOwnTeam" : MessageLookupByLibrary.simpleMessage("Owned"),
    "TeamsLocalizations_labelSave" : MessageLookupByLibrary.simpleMessage("Save"),
    "TeamsLocalizations_labelSearchTeams" : MessageLookupByLibrary.simpleMessage("Search Teams"),
    "TeamsLocalizations_labelStatus" : MessageLookupByLibrary.simpleMessage("Team Activity State"),
    "TeamsLocalizations_labelStatusActive" : MessageLookupByLibrary.simpleMessage("Active"),
    "TeamsLocalizations_labelStatusClosed" : MessageLookupByLibrary.simpleMessage("Closed"),
    "TeamsLocalizations_labelStatusPending" : MessageLookupByLibrary.simpleMessage("Pending"),
    "TeamsLocalizations_labelSummary" : MessageLookupByLibrary.simpleMessage("Team Summary"),
    "TeamsLocalizations_labelTeamAcceptInvitation" : MessageLookupByLibrary.simpleMessage("Accept Invitation"),
    "TeamsLocalizations_labelTeamDenyInvitation" : MessageLookupByLibrary.simpleMessage("Deny Invitation"),
    "TeamsLocalizations_labelTeamInvite" : MessageLookupByLibrary.simpleMessage("Invite"),
    "TeamsLocalizations_labelUnapplyTeam" : MessageLookupByLibrary.simpleMessage("Cancel application"),
    "TeamsLocalizations_labelVisibilityGroup" : MessageLookupByLibrary.simpleMessage("Same team group members"),
    "TeamsLocalizations_labelVisibilityMembers" : MessageLookupByLibrary.simpleMessage("Team members only"),
    "TeamsLocalizations_labelVisibilityPublic" : MessageLookupByLibrary.simpleMessage("Public"),
    "TeamsLocalizations_labelVisibilityRegistered" : MessageLookupByLibrary.simpleMessage("Registered users only"),
    "TeamsLocalizations_titleCreate" : MessageLookupByLibrary.simpleMessage("Create Team"),
    "TeamsLocalizations_titleMyTeams" : MessageLookupByLibrary.simpleMessage("My Teams"),
    "TeamsLocalizations_titleUpdate" : MessageLookupByLibrary.simpleMessage("Update Team"),
    "TeamsLocalizations_titleView" : MessageLookupByLibrary.simpleMessage("Team")
  };
}
