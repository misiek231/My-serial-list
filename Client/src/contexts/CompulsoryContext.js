import React, { createContext, useState } from 'react';

export const CompulsoryContext = createContext();

const CompulsoryContextProvider = (props) => {
    const [compulsoryData] = useState({
        ip: 'https://35.184.110.50'
    });

    return (
        <CompulsoryContext.Provider value={{compulsoryData}}>
            {props.children}
        </CompulsoryContext.Provider>
      );
}
 
export default CompulsoryContextProvider;