import React, { useEffect, useContext, useState } from 'react';
import { Spin } from 'antd';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import '../../styles/ListViewStyles/Series.scss';
import ItemTemplate from './ItemTemplate';
import '../../styles/ListViewStyles/Series.scss';
import { useBottomScrollListener } from 'react-bottom-scroll-listener';

const TopList = () => {
    const { compulsoryData } = useContext(CompulsoryContext);
    const [topSeries, setTopSeries] = useState([]);
    const [page, setPage] = useState(1);

    useEffect(() =>{
      getTop();
    }, []);

    useBottomScrollListener(()=>{
        if(topSeries[topSeries.length-1]!==undefined &&!topSeries[topSeries.length-1].last){
            getTop();
        }
    });
    const getTop = () =>{
        axios.get(compulsoryData.ip + '/api/FilmProduction/get_all?page=' + page)
        .then(res =>{
           setTopSeries(topSeries.concat(res.data));
           setPage(page+1);
        })
        .catch(err =>{
            console.error(err);
        })
    }
  

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