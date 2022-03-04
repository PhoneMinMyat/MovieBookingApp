//Url
// ignore_for_file: constant_identifier_names

const String BASE_TMBA_URL_DIO = 'https://tmba.padc.com.mm';
const String BASE_MOVIE_DB_URL_DIO = 'https://api.themoviedb.org';
const String IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w400/';

//ENDPOINTS
const String ENDPOINTS_POST_REGISTER = '/api/v1/register';
const String ENDPOINTS_POST_LOGIN_WITH_EMAIL = '/api/v1/email-login';
const String ENDPOINTS_POST_LOGIN_WITH_GOOGLE = '/api/v1/google-login';
const String ENDPOINTS_POST_LOGIN_WITH_FACEBOOK = '/api/v1/facebook-login';
const String ENDPOINTS_GET_NOW_PLAYING = '/3/movie/now_playing';
const String ENDPOINTS_GET_UPCOMING = '/3/movie/upcoming';
const String ENDPOINTS_GET_MOVIE_DETAILS = '/3/movie';
const String ENDPOINTS_GET_GENRES = '/3/genre/movie/list';
const String ENDPOINTS_LOG_OUT = '/api/v1/logout';
const String ENDPOINTS_GET_CINEMA_TIMESLOT = '/api/v1/cinema-day-timeslots';
const String ENDPOINTS_CINEMA_SEATING_PLAN = '/api/v1/seat-plan';
const String ENDPOINTS_GET_SNACK_LIST = '/api/v1/snacks';
const String ENDPOINTS_GET_PAYMENT_METHOD = '/api/v1/payment-methods';
const String ENDPOINTS_GET_PROFILE = '/api/v1/profile';
const String ENDPOINTS_POST_CREATE_CARD = '/api/v1/card';
const String ENDPOINTS_CHECKOUT = '/api/v1/checkout';

const String HEADER_CONTENT_TYPE = 'Content-Type';
const String HEADER_ACCEPT = 'Accept';
const String APPLICATION_JSON = 'application/json';

/// Parameters
const String PARAM_NAME = 'name';
const String PARAM_EMAIL = 'email';
const String PARAM_PHONE = 'phone';
const String PARAM_PASSWORD = 'password';
const String PARAM_GOOGLE_ACCESS_TOKEN = 'google-access-token';
const String PARAM_FACEBOOK_ACCESS_TOKEN = 'facebook-access-token';
const String PARAM_API_KEY = 'api_key';
const String PARAM_LANGUAGE = 'language';
const String PARAM_PAGE = 'page';
const String PARAM_GENRE_ID = 'with_genres';
const String PARAM_AUTHORIZATION = 'Authorization';
const String PARAM_MOVIE_ID = 'movie_id';
const String PARAM_DATE = 'date';
const String PARAM_CINEMA_DAY_TIMESLOT_ID = 'cinema_day_timeslot_id';
const String PARAM_BOOKING_DATE = 'booking_date';
const String PARAM_CARD_NUMBER = 'card_number';
const String PARAM_CARD_HOLDER = 'card_holder';
const String PARAM_EXPIRATION_DATE = 'expiration_date';
const String PARAM_CVC = 'cvc';
const String PARAM_ACCESS_TOKEN = 'access-token';

// Constant Values
const String API_KEY = 'ea1b7bd86e6fcf494923b598214b827c';
const String LANGUAGE_EN_US = 'en-US';
