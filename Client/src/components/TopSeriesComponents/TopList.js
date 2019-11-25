import React, { useEffect, useContext, useState } from 'react';
import { Spin } from 'antd';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import '../../styles/ListViewStyles/Series.scss';
import ItemTemplate from './ItemTemplate';
import '../../styles/ListViewStyles/Series.scss';
import { useBottomScrollListener } from 'react-bottom-scroll-listener';

const TopList = () => {
    const { compulsoryData} = useContext(CompulsoryContext);
    const [topSeries, setTopSeries] = useState([]);
    const [page, setPage] = useState(1);
    const [spin, setSpin] = useState(true);

    useEffect(() =>{
        console.log('kliknąłeś xD')
            if(page === 1){
                getTop();
            }else{
                setPage(1);
            }
    }, [compulsoryData.title]);

    useBottomScrollListener(()=>{
        if(topSeries[topSeries.length-1]!==undefined &&!topSeries[topSeries.length-1].last){
            setPage(page+1);
        }
    });

    useEffect(() =>{
        getTop();
    },[page])

    const getTop = () =>{
        console.log(page)
        let link = compulsoryData.ip + '/api/FilmProduction/get_all?page=' + page;
        if(compulsoryData.title !== ""){
            link += "&search=" + compulsoryData.title;
        }
        setSpin(true);
        axios.get(link)
        .then(res =>{
            setSpin(false);
           setTopSeries(page===1 ? (res.data) : (topSeries.concat(res.data)));
        })
        .catch(err =>{
            console.error(err);
        })
    }
     
    const top = topSeries.map(item =>{
        return(
            <ItemTemplate key={item.filmProductionId} data={item}></ItemTemplate>
        )
        }) 
    return (  
        <div className="series">
            {top}
            { spin ? ( <div className="spinner"><Spin/></div>):
            (<span className="spinner" style={{margin: '10px 0'}}>Brak wyników</span>)}
        </div>
    );
}
 
export default TopList;