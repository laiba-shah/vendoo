import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
    // Return a stream with a mock user
    final mockUser = MockUser();
    return Stream.value(mockUser);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // Return a future with a mock user credential
    final mockUserCredential = MockUserCredential();
    return Future.value(mockUserCredential);
  }

  // Add more mock implementations of FirebaseAuth methods as needed
}

class MockUser extends Mock implements User {
  // Implement any necessary User properties or methods for testing
}

class MockUserCredential extends Mock implements UserCredential {
  // Implement any necessary UserCredential properties or methods for testing
}
