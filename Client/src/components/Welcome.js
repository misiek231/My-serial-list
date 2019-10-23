import React from 'react';
import '../styles/ListViewStyles/ListView.scss';
import TopActions from './TopSeriesComponents/TopActions';
import TopList from './TopSeriesComponents/TopList';
const Welcome = () => {
    return ( 
        <main className="listView">
            <TopActions/>
            <TopList/>
        </main>
     );
}
 
export default Welcome;