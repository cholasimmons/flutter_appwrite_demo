import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_demo/_constants/constants.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
    uninitialized,
    authenticated,
    unauthenticated,
}

class AuthAPI extends ChangeNotifier {
    Client client = Client();
    late final Account account;

    late User _currentUser;

    AuthStatus _status = AuthStatus.uninitialized;

    // Getter methods
    User get currentUser => _currentUser;
    AuthStatus get status => _status;
    String? get username => _currentUser.name;
    String? get email => _currentUser.email;
    String? get userId => _currentUser.$id;
    
    // Constructor
    AuthAPI(){
        init();
        loadUser();
    }

    // initialize Appwrite Client
    init(){
        client
        .setEndpoint(APPWRITE_URL)
        .setProject(APPWRITE_PROJECT_ID)
        .setSelfSigned(status: true); // For self signed certificates, only use for development

        // Register User
        account = Account(client);
    }

    loadUser() async {
        try{
            final user = await account.get();
            _status = AuthStatus.authenticated;
            _currentUser = user;

        } catch(e) {
            _status = AuthStatus.unauthenticated;
        } finally {
            notifyListeners();
        }
    }

    Future<User> createUser({
        required String email, required String password}) async {
            notifyListeners();

            try {
                // ignore: unused_local_variable
                final user = await account.create(
                userId: ID.unique(),
                email: email,
                password: password,
                name: email);
                return user;
            } finally {
                notifyListeners();
            }
    }

    Future<Session> createEmailSession({
        required String email, required String password}) async {
            try {
                final session = await account.createEmailSession(email:email, password:password);
                _currentUser = await account.get();
                _status = AuthStatus.authenticated;
                return session;
            } finally {
                notifyListeners();
            }
    }

    signInWithProvider({required String provider}) async {
        try {
            final session = await account.createOAuth2Session(provider: provider);
            _currentUser = await account.get();
            _status = AuthStatus.authenticated;
            return session;
        } finally {
            notifyListeners();
        }
    }

    signOut() async {
        try {
            await account.deleteSession(sessionId: 'current');
            _status = AuthStatus.unauthenticated;
        } finally {
            notifyListeners();
        }
    }

    Future<Preferences> getUserPreferences() async {
        return await account.getPrefs();
    }

    updatePreferences({required String bio}) async {
        return account.updatePrefs(prefs: {'bio': bio});
    }
    
    


  // Subscribe to files channel
  // final realtime = Realtime(client);
  // final subscription = realtime.subscribe(['files']);

//   subscription.stream.listen((response) {
//     if (response.events.contains('buckets.*.files.*.create')) {
//       // Log when a new file is uploaded
//       print(response.payload);
//     }
//   });
}