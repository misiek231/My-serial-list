import React, { useEffect } from 'react';
import '../styles/Header.scss';
import { Link, withRouter } from 'react-router-dom';
import { Icon } from 'antd';
import { checkAuth } from '../actions/checkAuth';
import { withCookies } from 'react-cookie';

// Header visible on every page 

const Header = ({cookies}) => {
    useEffect(() =>{
        if(cookies.get('token') !== undefined){
            const token = cookies.get('token');
            checkAuth(token);
        }
    }, [cookies]);
    
    return ( 
        <header>
            <Icon type="read"/>
            <Link to="/">MySerialList</Link>
        </header>
     );
}
 
export default withRouter(withCookies(Header));