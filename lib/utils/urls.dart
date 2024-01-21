// OnBoarding
const String baseUrl = 'https://gearup-backend.onrender.com/api/v1';
const String registerUserUrl = "$baseUrl/user/register";
const String verifyUserUrl = "$baseUrl/user/otp_verification";
const String updateUserUrl = "$baseUrl/user/update";

// Home
const String fetchAllPlayersUrl = "$baseUrl/user/getPlayers";

// Games
const String fetchAllGamesUrl = "$baseUrl/game/games";
const String fetchMyGamesUrl = "$baseUrl/game/mygames";
const String fetchMyRecentGamesUrl = "$baseUrl//game/recentGames";
const String fetchMyLiveGamesUrl = "$baseUrl//game/liveGames";
const String fetchMyUpcomingGamesUrl = "$baseUrl//game/upcomingGames";

// Profile
const String fetchPlayerProfileDataUrl = "$baseUrl/user/getAnyPlayer";
const String fetchUserProfileDataUrl = "$baseUrl/user/mydata";
