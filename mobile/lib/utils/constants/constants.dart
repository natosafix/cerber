abstract class Constants {
  // emulator
  static const authenticationRepositoryBaseUrl = 'https://10.0.2.2:7061/auth';
  static const eventsRepositoryBaseUrl = 'https://10.0.2.2:7061';
  
  // to test qr code scanning on a real device
  // see https://stackoverflow.com/questions/4779963/how-can-i-access-my-localhost-from-my-android-device
  // adb reverse worked for me
  // static const authenticationRepositoryBaseUrl = 'https://localhost:7061/auth';
  // static const eventsRepositoryBaseUrl = 'https://localhost:7061';

  // static const authenticationRepositoryBaseUrl = 'http://51.250.29.158:80/auth';
  // static const eventsRepositoryBaseUrl = 'http://51.250.29.158:80';
}
