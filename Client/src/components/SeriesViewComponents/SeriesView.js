import React, { useEffect, useContext } from 'react';
import '../../styles/SeriesViewStyles/SeriesView.scss';
import { withRouter } from 'react-router-dom';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import { setOneSeries } from '../../actions/oneSeriesActions';
import { OneSeriesContext } from '../../contexts/OneSeriesContext';
import SeriesData from './SeriesData';

const SeriesView = (props) => {
    const {compulsoryData} = useContext(CompulsoryContext);
    const {oneSeries, dispatch} = useContext(OneSeriesContext)
    useEffect(() =>{
        axios.get(compulsoryData.ip + '/api/FilmProduction/' + props.match.params.id)
        .then(res =>{
            dispatch(setOneSeries(res.data));
        })
        .catch(err =>{
            console.error(err);
        })
    }, []);
    return ( 
        <main className="seriesView">
            <div className="seriesPoster">
                <img src={'https://myseriallist.ml/images/' + oneSeries.oneSeries.poster}/>
            </div>
            <SeriesData/>
        </main>
     );
}
 
export default withRouter(SeriesView);