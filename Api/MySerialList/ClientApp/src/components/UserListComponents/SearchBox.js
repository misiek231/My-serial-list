import React, {useContext} from 'react'
import { Input } from 'antd';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';

const { Search } = Input;

const SearchBox = () => {
    const {compulsoryData, setData} = useContext(CompulsoryContext);
    const setTitle = (value) =>{
            setData({...compulsoryData, title: value})
    }

    return ( 
        <div className='searchBox'>
            <Search
                placeholder="Wyszukaj film"
                onChange={e => setTitle(e.target.value)}
                onPressEnter={e => setTitle(e.target.value)}
                style = {{width: '80%', marginBottom: '20px'}}
                allowClear
            />
        </div>
     );
}
 
export default SearchBox;