import 'package:autismcompanionsupport/services/auth/auth_exceptions.dart';
import 'package:autismcompanionsupport/services/auth/auth_provider.dart';
import 'package:autismcompanionsupport/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot logout if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>())
      );
    });

    test('Should be initialized to begin with', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialize', () async {
      expect(provider.currentUser, null);
    });

    test('Should be able to initialized in less than 2 seconds', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, 
      timeout: const Timeout(Duration(seconds: 2))
    );

    test('Create user should delegate to login function', () async {
      final badEmailUser = provider.createUser(
        email: 'foo@bar.com', 
        password: 'anypassworkd',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>())
      );

      final badPasswordUser = provider.createUser(
        email: 'any@gmail.com', 
        password: 'foobar',
      );
      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>())
      );

      final user = await provider.createUser(
        email: 'foo', 
        password: 'bar',
      );
      expect(provider.currentUser, user);
      expect(user!.isEmailVerified, false);
    });

    test('Logged In user should be able to get verified', () async {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('User should be able to logout and login again', () async {
      await provider.logOut();
      await provider.login(email: 'email', password: 'password');
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;

  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser?> createUser({
    required String email, 
    required String password,
  }) async {
    if(!isInitialized) throw NotInitializedException();
    Future.delayed(const Duration(seconds: 1));
    return login(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<void> logOut() async {
    if(!isInitialized) throw NotInitializedException();
    if(_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<AuthUser?> login({
    required String email, 
    required String password,
  }) async {
    if(!isInitialized) throw NotInitializedException();
    if(email == 'foo@bar.com') throw UserNotFoundAuthException();
    if(password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(
      id: 'my_id',
      isEmailVerified: false,
      email: 'foo@bar.com',
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> sendEmailVerification() async {
    if(!isInitialized) throw NotInitializedException();
    final user = _user;
    if(user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      id: 'my_id',
      email: "foo@bar.com",
      isEmailVerified: true,
    );
    _user = newUser;
  }
}