import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data_layer/network/failure.dart';
import '../../data_layer/request/request.dart';
import '../../data_layer/responses/responses.dart';

class LoginUseCase {
  GoogleSignIn _googleSingIn = GoogleSignIn();
  LoginUseCase();
  // Future<Either<Failure, AuthenticationResponse>> execute(
  //     String email, String password) async {
  //   // return await instance<RepositoryImpl>()
  //   //     .login(LoginRequest(email, password));
  // }

  Future<GoogleSignInAccount?> loginGoogleAuth(String email) async {
    return await _googleSingIn.signIn();
  }
}
