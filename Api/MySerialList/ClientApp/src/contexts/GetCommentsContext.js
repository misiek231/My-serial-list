import React, { createContext, useReducer } from 'react';
import { setCommentsReducer } from '../reducers/setCommentsReducer';

export const CommentsContext = createContext();

const CommentsContextProvider = (props) => {
    const [comments, dispatch] = useReducer(setCommentsReducer,{
        comments: ''
    });
    return (
        <CommentsContext.Provider value={{comments, dispatch}}>
            {props.children}
        </CommentsContext.Provider>
     );
}
 
export default CommentsContextProvider;
