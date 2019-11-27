import React, {useState, useEffect, useContext} from 'react';
import { Link } from 'react-router-dom';
import { Icon } from 'antd';
import '../../styles/UserListStyles/FilmTemplate.scss';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import CollapseMenu from './CollapseMenu';

const ItemTemplate = ({data, status, getUserFilms}) => {
    const {compulsoryData} = useContext(CompulsoryContext);
    const [series, setSeries] = useState('')
    useEffect(()=>{
        if(!data.isSeries){
            setSeries('hidden')
        }
    },[]);

    const updateEpisode = (e, operator) =>{
        e.preventDefault();
        if(data.watchedEpisodes === 0 || (data.watchedEpisodes === data.totalEpisodes)){
            return
        }
        axios.put(compulsoryData.ip + '/api/UserFilmProductions/update',{
            filmProductionId: data.filmProductionId,
            watchingStatus: status,
            episodes: !data.isSeries ? (1):(data.watchedEpisodes + operator)
        })
        .then(res =>{
            getUserFilms();
        })
        .catch(err =>{

        })
    }
   
    return ( 
        <div className="template">
            <Link to={'/series/' + data.filmProductionId} className="seriesTemplate" key={data.filmProductionId} className="user-film">
                <div className="user-list-poster">
                    <img src={data.poster} alt="There was a poster for this series"/>
                </div>
                <div className="user-film-data">
                    <div className="user-list-title"><span>{data.title}</span></div>
                    <div className="user-list-details user-list-genre">
                        <span>Gatunek:</span>
                        <span className="bold-value">{data.genre}</span>
                    </div>
                    <div className="user-list-details user-list-rating">
                        <span>Ocena:</span>
                        <span className="bold-value">
                            {data.rating}
                        </span>
                    </div>
                    <div className={series + " user-list-episodes"}>
                        <span>Odcinki:</span>
                        <span className="bold-value watched-episodes">{data.watchedEpisodes + '/' + data.totalEpisodes}
                            <span className="episodes-controles">
                                <span onClick={e => {updateEpisode(e, -1)}}><Icon type="minus-circle" theme="filled" /></span>
                                <span>/</span>
                                <span onClick={e => {updateEpisode(e, +1)}}><Icon type="plus-circle" theme="filled" /></span>
                            </span>
                        </span>
                    </div>
                </div>
            </Link>
            <CollapseMenu status={status} id={data.filmProductionId} total={data.totalEpisodes} isSeries={data.isSeries} getUserFilms={getUserFilms}/>
        </div>
     );
}
 
export default ItemTemplate;