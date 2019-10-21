import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Icon } from 'antd';
import '../../styles/ListViewStyles/TopActions.scss';

const TopActions = () => {
    const [logoutClass, setLogoutClass] = useState(' logout');

    return ( 
    <div className="top-actions">
        <div className="actions-option">
            <Link to="/signin">
                <Icon type="login" style={{marginRight: '8px'}}/>
                Zaloguj się
            </Link>
        </div>
        <div className="actions-option">
            <Link to="/signup">
                <Icon type="form" style={{marginRight: '8px'}}/>
                Zarejestruj się
            </Link>
        </div>
        <div className="actions-option">
            <Link to="listview/current">
                <Icon type="menu-unfold" style={{marginRight: '8px'}}/>
                Lista
            </Link>
        </div>
        <div className={'actions-option' + logoutClass}>
                <Icon type="logout" style={{marginRight: '8px'}}/>
                <span>Wyloguj</span>
        </div>
    </div>
     );
}
 
export default TopActions;