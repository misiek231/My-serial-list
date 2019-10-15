import React, { createContext, useReducer } from 'react';
import { signInReducer } from '../reducers/signInReducer';

export const SignInContext = createContext();

const SignInContextProvider = (props) => {
    const [signInData, dispatch] = useReducer(signInReducer,{
       signInUser:{
            username: '',
            password: ''
        }
    });

    return (
        <SignInContext.Provider value={{signInData, dispatch}}>
            {props.children}
        </SignInContext.Provider>
      );
}
 
export default SignInContextProvider;