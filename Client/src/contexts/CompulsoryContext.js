import React, { createContext, useState } from 'react';

export const CompulsoryContext = createContext();

const CompulsoryContextProvider = (props) => {
    const [compulsoryData, setData] = useState({
        ip: 'https://myseriallist.ml',
        title: ""
    });

    return (
        <CompulsoryContext.Provider value={{compulsoryData, setData}}>
            {props.children}
        </CompulsoryContext.Provider>
      );
}
 
export default CompulsoryContextProvider;