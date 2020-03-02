import React, {useState, useEffect} from 'react';
import { Icon } from 'antd';
import { Link, withRouter } from 'react-router-dom';

const ListViewActions = (props) => {
    const handleClick = () =>{
        props.history.push('/');
    }

    return ( 
    <div className="actions">
        <div className="actions-option" onClick={handleClick}>
            <Icon type="plus" style={{marginRight: '8px'}}/>
            Dodaj serial
        </div>
        <div className="actions-option">
            <Link to={"/listview/current/" + props.match.params.username}>
                <Icon type="fire" style={{marginRight: '8px'}}/>
                Aktualne
            </Link>
        </div>
        <div className="actions-option">
            <Link to={"/listview/planned/" + props.match.params.username}>
                <Icon type="search" style={{marginRight: '8px'}}/>
                Planowane
            </Link>
        </div>
        <div className="actions-option">
            <Link to={"/listview/completed/" + props.match.params.username}>
                <Icon type="carry-out" style={{marginRight: '8px'}}/>
                Zakończone
            </Link>
        </div>
    </div>
     );
}
 
export default withRouter(ListViewActions);