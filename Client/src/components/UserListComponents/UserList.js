import React, {useEffect, useState, useContext} from 'react';
import axios from 'axios';
import { withRouter } from 'react-router-dom';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import { Spin } from 'antd';
import FilmTemplate from '../UserListComponents/FilmTemplate';

const UserList = (props) => {
    const {compulsoryData} = useContext(CompulsoryContext);
    const [spin,setSpin] = useState(true);
    const [films, setFilms] = useState([]);

    useEffect(()=>{
        getUserFilms();
    },[props.match.url])

    const getUserFilms = () =>{
        setSpin(true);
        axios.get(compulsoryData.ip + '/api/UserFilmProductions/get_film_productions/' + props.match.params.username + '?status=' + props.status)
        .then(res =>{
            setSpin(false);
            setFilms(res.data);
        })
        .catch(err=>{
            
        })
    }

    const returnFilms = !spin ? (films.map(film =>{
        return(
            <FilmTemplate key={film.filmProductionId} data={film} status={props.status} getUserFilms={getUserFilms}/>
        )
    })):(<Spin/>)
    return ( 
        <div className="user-list">
          {returnFilms}
        </div>
     );
}
 
export default withRouter(UserList);