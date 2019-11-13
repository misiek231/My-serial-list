import React, { useState, useContext } from 'react';
import { Button } from 'antd';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';

const AddSeries = ({episodes, id, cookies}) => {
    const [list, setList] = useState({
            watchingStatus: 0,
            episodes: 0
    })
    const [grade, setGrade] = useState(0);
    const [submitting, setSubmitting] = useState(false);
    const [gradeSubmitting, setGradeSubmitting] = useState(false);

    const { compulsoryData } = useContext(CompulsoryContext);

    const handleChange = (name, value) =>{
        if(isNaN(value)){
            value = 0
        }
        if(name === 'episodes' && value>episodes){
            value=episodes
        }
       setList({...list,[name]: value})
    }
    
    const handleRating = (value) =>{
        if(isNaN(value)){
            value = 0
        }
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
            console.log(res);
        })
        .catch(err =>{
            setSubmitting(false);
            console.log(err)
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
        })
    }

    return ( 
        <div className="addSeries">
            <form>
                <div className="selectStatus">
                    <span>Status:</span>
                    <select onChange={e => {handleChange('watchingStatus', parseInt(e.target.value))}}>
                        <option value={0}>Aktualnie oglądane</option>
                        <option value={1}>Zakończone</option>
                        <option value={2}>Planowane</option>
                    </select>
                </div>
                <div className="episodes">
                    <span className="episodes-number">Liczba odcinków:</span>
                    <span className="inputSpan"><input type="text" value={list.episodes} onChange={e =>{handleChange('episodes',parseInt(e.target.value))}}></input><span>{'/'+episodes}</span></span>
                </div>
                <Button htmlType="submit" loading={submitting} onClick={handleSubmit} className="addSeriesButton">
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
                <Button htmlType="submit" loading={gradeSubmitting} onClick={handleRatingSubmit} className="addSeriesButton">
                   Dodaj ocenę
                </Button>
            </form>
        </div>
     );
}
 
export default AddSeries;