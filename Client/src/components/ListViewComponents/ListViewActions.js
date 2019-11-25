import React from 'react';
import { Icon } from 'antd';
import { Link, withRouter } from 'react-router-dom';

const ListViewActions = (props) => {

    const handleClick = () =>{
        props.history.push('/search');
    }
    return ( 
    <div className="actions">
        <div className="actions-option" onClick={handleClick}>
            <Icon type="plus" style={{marginRight: '8px'}}/>
            Dodaj serial
        </div>
        <div className="actions-option">
            <Link to="listview/current">
                <Icon type="fire" style={{marginRight: '8px'}}/>
                Aktualne
            </Link>
        </div>
        <div className="actions-option">
            <Link to="listview/planned">
                <Icon type="search" style={{marginRight: '8px'}}/>
                Planowane
            </Link>
        </div>
        <div className="actions-option">
            <Link to="listview/finished">
                <Icon type="carry-out" style={{marginRight: '8px'}}/>
                Zakończone
            </Link>
        </div>
    </div>
     );
}
 
export default withRouter(ListViewActions);