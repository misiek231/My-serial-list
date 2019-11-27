import React, { useState, useEffect } from 'react';
import { Link, withRouter } from 'react-router-dom';
import { withCookies } from 'react-cookie';
import { Icon } from 'antd';
import '../../styles/ListViewStyles/TopActions.scss';

const TopActions = (props) => {
    const [logoutClass, setLogoutClass] = useState(' logout');
    const [loginClass, setLoginClass] = useState(' login')
    useEffect(() =>{
        if(props.cookies.get('token') !== undefined){
            setLogoutClass(' logout-on')
            setLoginClass(' login-out')
        }
    }, [props.cookies]);

    const handleClick = () =>{
        props.cookies.remove('token');
        setTimeout(() =>{
            props.history.push('/signin');
        }, 1000)
    }

    return ( 
    <div className="top-actions">
        <div className={"actions-option"+ loginClass}>
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
        <div className={"actions-option" + logoutClass}>
            <Link to={'/listview/current/' + props.cookies.get('username')}>
                <Icon type="menu-unfold" style={{marginRight: '8px'}}/>
                Lista
            </Link>
        </div>
        <div className={'actions-option' + logoutClass} onClick={handleClick}>
                <Icon type="logout" style={{marginRight: '8px'}}/>
                <span>Wyloguj</span>
        </div>
    </div>
     );
}
 
export default withRouter(withCookies(TopActions));