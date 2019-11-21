const API_URL = 'https://myseriallist.ml/api';
const IMAGES_URL = 'https://myseriallist.ml/images';

//AUTHENTICATION
const LOGIN_URL = '$API_URL/account/login';
const REGISTER_URL = '$API_URL/account/create';
const GET_ALL = '$API_URL/FilmProduction/get_all';
const GET_FILM_PRODUCTION = '$API_URL/FilmProduction';
const GET_COMMENTS = '$API_URL/ReviewFilmProduction/get_comments';
const GET_EPISODES = '$API_URL/Episode/get_all';

Pattern emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

enum FilmProductionType { all, films, serials }
