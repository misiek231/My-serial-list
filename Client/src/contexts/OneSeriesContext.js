import React, { createContext, useReducer } from 'react';
import { oneSeriesReducer } from '../reducers/oneSeriesReducer';

export const OneSeriesContext = createContext();

const OneSeriesContextProvider = (props) => {
    const [oneSeries, dispatch] = useReducer(oneSeriesReducer,{
        oneSeries:{
            title: "",
            genre: "",
            released: "",
            filmProductionId: null,
            poster: "",
            plot: "",
            votes: null,
            rating: null,
            isSeries: false
        }
    });
    return (
        <OneSeriesContext.Provider value={{oneSeries, dispatch}}>
            {props.children}
        </OneSeriesContext.Provider>
     );
}
 
export default OneSeriesContextProvider;
