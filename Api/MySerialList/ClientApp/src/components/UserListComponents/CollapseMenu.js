import React, {useEffect, useState, useContext} from 'react';
import { Collapse, Icon, Button } from 'antd';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';

const { Panel } = Collapse;
const CollapseMenu = (props) => {
    const [showOrHide, setShow] = useState('hide');
    const [loading, setLoading] = useState(false);
    const [update,setUpdate] = useState({
        filmProductionId: props.id,
        watchingStatus: props.status,
        episodes: 0
    })
    const {compulsoryData} = useContext(CompulsoryContext);
    useEffect(() =>{
        if(props.isSeries){
            setShow('show');
        }
    },[props.isSeries]);
    const handleChange = (name,value) =>{
        if(value===""){
            value = 0
        }
        parseInt(value);
        if(value > props.total){
            value=props.total
        }
        else if(value<0){
            value=0
        }else
        setUpdate({...update, [name]: value});
    }
    const handleSubmit = (e) =>{
        e.preventDefault();
        setLoading(true);
        axios.put(compulsoryData.ip + '/api/UserFilmProductions/update', update)
        .then(res =>{
            setLoading(false);
            props.getUserFilms();
        })
        .catch(err=>{
            setLoading(false);
        })
    }
    return (  
        <Collapse
        className="collapse"
        bordered={false}
        accordion
        expandIcon={({ isActive }) => <Icon type="caret-right" rotate={isActive ? 90 : 0} />}
        >
            <Panel header="Zmień status filmu oraz liczbę odcinków" key="1">
                <form onSubmit={e=>{handleSubmit(e)}}>
                    <div className="panel-content">
                        <select className="status-select" onChange={e=>{handleChange('watchingStatus', e.target.value)}} defaultValue={props.status}>
                            <option value={0}>Aktualnie oglądane</option>
                            <option value={1}>Zakończone</option>
                            <option value={2}>Planowane</option>
                        </select>
                        <span className={"episodes-input " + showOrHide}>
                            <input type="number" onChange={e=>{handleChange("episodes", e.target.value)}} value={update.episodes}/><span>{'/' + props.total}</span>
                        </span>
                    </div>
                    <div className="update-button">
                        <Button type="primary" htmlType="submit" style={{backgroundColor: '#7289da', border: 'none', fontWeight: 'bold'}} loading={loading}>Aktualizuj</Button>
                    </div>
                </form>
            </Panel>
        </Collapse> );
}
 
export default CollapseMenu;