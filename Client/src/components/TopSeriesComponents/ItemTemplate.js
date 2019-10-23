import React from 'react';
import { Link } from 'react-router-dom';

const ItemTemplate = ({data}) => {
    return ( 
        <Link to={'/series/' + data.filmProductionId} className="seriesTemplate" key={data.filmProductionId}>
            <div className="poster">
                <img src={'https://myseriallist.ml/images/' + data.poster} alt="There was a poster for this series"/>
            </div>
            <div className="description">
                <div className="title">{data.title}</div>
                <div className="genre">
                    <span>Gatunek:</span>
                    {data.genre}
                </div>
                <div className="date">
                    <span>Data wydania:</span>
                    {data.released}
                </div>
                <div>
                    <span>Ocena:</span>
                    {data.rating}
                </div>
            </div>
            <div className="plot">
                <span>Opis:</span>
                {data.plot}
            </div>
        </Link>
     );
}
 
export default ItemTemplate;