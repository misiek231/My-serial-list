import React from 'react';
import '../styles/Header.scss';
import { Icon } from 'antd';

// Header visible on every page 

const Header = () => {
    return ( 
        <header>
            <Icon type="read" />
            <h1>MySerialList</h1>
        </header>
     );
}
 
export default Header;