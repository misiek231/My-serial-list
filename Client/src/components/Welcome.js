import React from 'react';
import '../styles/ListViewStyles/ListView.scss';
import TopActions from './TopSeriesComponents/TopActions';
import TopList from './TopSeriesComponents/TopList';
import SearchBox from './UserListComponents/SearchBox';
const Welcome = () => {
    return ( 
        <main className="listView">
            <TopActions/>
            <SearchBox/>
            <TopList/>
        </main>
     );
}
 
export default Welcome;