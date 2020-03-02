import React, { useContext } from 'react';
import { OneSeriesContext } from '../../contexts/OneSeriesContext';
import AddComment from './AddComment';
import ShowComments from './ShowComments';
import CommentsContextProvider from '../../contexts/GetCommentsContext';
import AddSeries from './AddSeries';

const SeriesData = () => {
    const { oneSeries } = useContext(OneSeriesContext)

    return ( 
        <div className="seriesData">
            <div className="title">{oneSeries.oneSeries.title}</div>
            <div className="genre">
                <span>{'Gatunek: '+ oneSeries.oneSeries.genre}</span>
                <span>{'Data wydania: ' + oneSeries.oneSeries.released}</span>
            </div>
            <AddSeries episodes={oneSeries.oneSeries.episodes} id={oneSeries.oneSeries.filmProductionId} isSeries={oneSeries.oneSeries.isSeries}/>
            <div className="plot">
                <h1>Krótki opis fabuły:</h1>
                <p className="plotText">{oneSeries.oneSeries.plot}</p>
            </div>
            <CommentsContextProvider>
                <AddComment/>
                <ShowComments/>
            </CommentsContextProvider>
        </div>
     );
}
 
export default SeriesData;