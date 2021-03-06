import React, { useState, useContext, useEffect } from 'react';
import { Button, Tooltip } from 'antd';
import axios from 'axios';
import { withCookies } from 'react-cookie';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import { openNotificationWithIconErr } from '../../actions/notifications';

const AddSeries = ({episodes, id, isSeries, cookies}) => {
    const [list, setList] = useState({
            watchingStatus: 0,
            episodes: 0
    })
    const [series,setSeries] = useState('none')
    const [grade, setGrade] = useState(0);
    const [submitting, setSubmitting] = useState(false);
    const [gradeSubmitting, setGradeSubmitting] = useState(false);
    const [isDisabled, setDisabled] = useState(false);
    const { compulsoryData } = useContext(CompulsoryContext);

    useEffect(() =>{
        if(isSeries){
            setSeries('inline-flex');
        }
        if(cookies.get('token') === undefined){
            setDisabled(true)
        }
    },[])

    const handleChange = (name, value) =>{
        if(name === 'episodes' && value>episodes){
            value=episodes
        }
       setList({...list,[name]: value})
    }
    
    const handleRating = (value) =>{
           setGrade(value);
    }

    const handleSubmit = (e) =>{
        e.preventDefault();
        setSubmitting(true);
        axios.post(compulsoryData.ip + '/api/UserFilmProductions/add_film_production',{
            ...list,
            filmProductionId: id
        })
        .then(res =>{
            setSubmitting(false);
        })
        .catch(err =>{
            setSubmitting(false);
            openNotificationWithIconErr('error', 'Film znajduje się już na Twojej liście') 
        })
    }

    const handleRatingSubmit = (e) =>{
        e.preventDefault();
        setGradeSubmitting(true);
        axios.post(compulsoryData.ip + '/api/ReviewFilmProduction/add_review',{
            filmProductionId: id,
            grade: grade
        })
        .then(res =>{
            setGradeSubmitting(false);
        })
        .catch(err =>{
            setGradeSubmitting(false);
            openNotificationWithIconErr('error', 'Oceniłeś już film') 
        })
    }

    return ( 
        <div className="addSeries">
            <form>
                <div className="selectStatus">
                    <span>Status:</span>
                    <select onChange={e => {handleChange('watchingStatus', e.target.value)}}>
                        <option value={0}>Aktualnie oglądane</option>
                        <option value={1}>Zakończone</option>
                        <option value={2}>Planowane</option>
                    </select>
                </div>
                <div className="episodes" style={{display: series}}>
                    <span className="episodes-number">Liczba odcinków:</span>
                    <span className="inputSpan"><input type="number" value={list.episodes} onChange={e =>{handleChange('episodes',parseInt(e.target.value))}}></input><span>{'/'+episodes}</span></span>
                </div>
                <Button disabled={isDisabled} htmlType="submit" loading={submitting} onClick={handleSubmit} className="addSeriesButton">
                    <Tooltip placement='right' title='dupa'/>
                    Dodaj serię
                </Button>
            </form>
            <form>
                <div className="ratingStatus">
                        <span>Ocena:</span>
                        <select onChange={e => {handleRating(e.target.value)}}>
                            <option value={0}>0</option>
                            <option value={1}>1</option>
                            <option value={2}>2</option>
                            <option value={3}>3</option>
                            <option value={4}>4</option>
                            <option value={5}>5</option>
                            <option value={6}>6</option>
                            <option value={7}>7e</option>
                            <option value={8}>8</option>
                            <option value={9}>9</option>
                            <option value={10}>10</option>
                        </select>
                    </div>
                <Button disabled={isDisabled} htmlType="submit" loading={gradeSubmitting} onClick={handleRatingSubmit} className="addSeriesButton">
                   Dodaj ocenę
                </Button>
            </form>
        </div>
     );
}
 
export default withCookies(AddSeries);