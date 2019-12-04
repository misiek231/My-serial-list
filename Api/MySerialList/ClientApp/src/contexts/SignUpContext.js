import React, { createContext, useReducer } from 'react';
import { signUpReducer } from '../reducers/signUpReducer';

export const SignUpContext = createContext();

const SignUpContextProvider = (props) => {
    const [signUpData, dispatch] = useReducer(signUpReducer,{
        registerUser:{
            username: '',
            password: '',
            email: ''
        },
        ip: 'http://192.168.43.134:5000'
    });

    return (
        <SignUpContext.Provider value={{signUpData, dispatch}}>
            {props.children}
        </SignUpContext.Provider>
      );
}
 
export default SignUpContextProvider;