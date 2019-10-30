import React, { useState, useContext } from 'react';
import { Button } from 'antd';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';

const AddSeries = ({episodes, id}) => {
    const [list, setList] = useState({
            watchingStatus: 0,
            episodes: 0
    })
    const [submitting, setSubmitting] = useState(false);

    const { compulsoryData } = useContext(CompulsoryContext);

    const handleChange = (name, value) =>{
        if(isNaN(value)){
            value = 0
        }
       setList({...list,[name]: value})
    }

    const handleSubmit = () =>{
        setSubmitting(true);
        axios.post(compulsoryData.ip + '/api/UserFilmProductions/add_film_production',{
            ...list,
            filmProductionId: id
        })
        .then(res =>{
            setSubmitting(false);
            console.log(res)
        })
        .catch(err =>{
            console.log(err)
        })
    }

    return ( 
        <div className="addSeries">
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
                <span className="inputSpan"><input type="text" onChange={e =>{handleChange('episodes',parseInt(e.target.value))}}></input><span>{'/'+episodes}</span></span>
            </div>
            <Button htmlType="submit" loading={submitting} onClick={handleSubmit} className="addSeriesButton">
                Dodaj serię
            </Button>
        </div>
     );
}
 
export default AddSeries;