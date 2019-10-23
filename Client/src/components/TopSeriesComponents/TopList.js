import React, { useEffect, useContext, useState } from 'react';
import { Spin } from 'antd';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import '../../styles/ListViewStyles/Series.scss';
import ItemTemplate from './ItemTemplate';
import '../../styles/ListViewStyles/Series.scss';

const TopList = () => {
    const { compulsoryData } = useContext(CompulsoryContext);
    const [topSeries, setTopSeries] = useState([]);

    useEffect(() =>{
        axios.get(compulsoryData.ip + '/api/FilmProduction/top_rated')
        .then(res =>{
           setTopSeries(res.data);
        })
        .catch(err =>{
            console.error(err);
        })
    }, []);

    const top = topSeries.length > 0 ? (
        topSeries.map(item =>{
            return(
                <ItemTemplate key={item.filmProductionId} data={item}></ItemTemplate>
            )
        })
    ):(
        <div className="spinner">
            <Spin/>
        </div>
    )
   
    return (  
        <div className="series">
            <div className="header">
                <h2>Top lista</h2>
            </div>
            {top}
        </div>
    );
}
 
export default TopList;