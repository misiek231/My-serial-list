import { notification } from 'antd';

export const openNotificationWithIcon = type => {
    notification[type]({
      message: 'Wszystko OK!',
      description:
        'Pomyślnie dodano użytkownika',
    });
  };
  
  export const openNotificationWithIconErr = type => {
    notification[type]({
      message: 'Ups, coś poszło nie tak!',
      description:
        'Użytkownik figuruje już w bazie danych lub dane są niepoprawne',
    });
  };

  export const openNotificationWithIconWarning = type => {
    notification[type]({
      message: 'Błędne dane',
      description:
        'Hasła nie są zgodne',
    });
  };


  