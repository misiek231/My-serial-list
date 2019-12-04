import React from 'react';
import '../../styles/ListViewStyles/ListView.scss';
import ListViewActions from './ListViewActions';
import UserList from '../UserListComponents/UserList';

const ListView = ({header, status}) => {
    console.log(status);
    return ( 
        <main className="listView">
            <ListViewActions/>
            <h1>{header}</h1>
            <UserList status={status}/>
        </main>
     );
}
 
export default ListView;