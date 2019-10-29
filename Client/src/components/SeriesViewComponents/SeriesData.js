import React, { useContext } from 'react';
import { OneSeriesContext } from '../../contexts/OneSeriesContext';
import AddComment from './AddComment';
import ShowComments from './ShowComments';

const SeriesData = () => {
    const { oneSeries } = useContext(OneSeriesContext)

    return ( 
        <div className="seriesData">
            <div className="title">{oneSeries.oneSeries.title}</div>
            <div className="genre">
                <span>{'Gatunek: '+ oneSeries.oneSeries.genre}</span>
                <span>{'Data wydania: ' + oneSeries.oneSeries.released}</span>
            </div>
            <div className="plot">
                <h1>Krótki opis fabuły:</h1>
                <p className="plotText">{oneSeries.oneSeries.plot}</p>
            </div>
            <AddComment/>
            <ShowComments/>
        </div>
     );
}
 
export default SeriesData;