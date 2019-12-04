import { notification } from 'antd';

export const openNotificationWithIcon = (type,mess) => {
    notification[type]({
      message: 'Wszystko OK!',
      description:
        'Pomyślnie dodano użytkownika',
    });
  };
  
  export const openNotificationWithIconErr = (type,mess) => {
    notification[type]({
      message: 'Ups, coś poszło nie tak!',
      description: mess
    });
  };

  export const openNotificationWithIconWarning = (type,mess) => {
    notification[type]({
      message: 'Błędne dane',
      description:
      mess,
    });
  };


  