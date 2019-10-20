import React from 'react';
import { Icon } from 'antd';
import { Link } from 'react-router-dom';
import '../../styles/ListViewStyles/ListView.scss';

const ListView = ({header}) => {

    return ( 
        <main className="listView">
            <div className="actions">
                <div className="actions-option">
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
            <h1>{header}</h1>
        </main>
     );
}
 
export default ListView;