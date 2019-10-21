import React from 'react';
import '../styles/Header.scss';
import { Link } from 'react-router-dom';
import { Icon } from 'antd';

// Header visible on every page 

const Header = () => {
    return ( 
        <header>
            <Icon type="read"/>
            <Link to="/">MySerialList</Link>
        </header>
     );
}
 
export default Header;