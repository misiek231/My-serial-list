import React from 'react';
import '../../styles/ListViewStyles/ListView.scss';
import ListViewActions from './ListViewActions';

const ListView = ({header}) => {

    return ( 
        <main className="listView">
            <ListViewActions/>
            <h1>{header}</h1>
        </main>
     );
}
 
export default ListView;