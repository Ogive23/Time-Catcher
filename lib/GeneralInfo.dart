import 'Screens/ProfileScreen.dart';
import 'Screens/ScheduleFriendCatcherScreen.dart';
import 'Screens/FriendCatcherScreen.dart';
import 'Screens/LocateFriendScreen.dart';
import 'Screens/TopThree/HomeScreen.dart';
import 'Screens/SettingsScreen.dart';
import 'Screens/StayInTouchScreen.dart';

enum Pages {
  StayInTouchScreen,
  HomeScreen,
  SettingsScreen,
  LocateFriendScreen,
  FriendCatcherScreen,
  ScheduleFriendCatcherScreen,
  ProfileScreen,
}

final pageOptions = [
  StayInTouchScreen(),
  HomeScreen(),
  SettingsScreen(),
  LocateFriendScreen(),
  FriendCatcherScreen(),
  ScheduleFriendCatcherScreen(),
  ProfileScreen(),
];
