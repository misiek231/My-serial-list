import axios from 'axios';

export const checkAuth = (token) =>{
    axios.interceptors.request.use(function(config) {
        config.headers.Authorization = `Bearer ${token}`;
        return config;
      },function(err){
          return Promise.reject(err);
        });
}