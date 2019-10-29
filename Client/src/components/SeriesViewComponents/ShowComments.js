import React, { useEffect, useState, useContext } from 'react';
import { withRouter } from 'react-router-dom';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import uuid from 'uuid/v1';

const ShowComments = (props) => {
    const {compulsoryData} = useContext(CompulsoryContext);
    const [comments, setComments] = useState([])
    useEffect(() =>{
        axios.get(compulsoryData.ip + '/api/ReviewFilmProduction/get_comments/' + props.match.params.id)
        .then(res =>{
            setComments(res.data);
        })
        .catch(err =>{
            console.error(err);
        })
    }, [])

    const commentData = comments.length > 0 ? (
        comments.map(comment =>{
            return(
                <div className="singleComment" key={uuid()}>
                    <div className="comment-data">
                        <span>{comment.username}</span>
                        <span>{comment.createAt}</span>
                    </div>
                    <div className="comment-content">{comment.description}</div>
                </div>
            )
        })
    ) : (
        <p>Brak komentarzy do tego filmu</p>
    )
    return ( 
        <div className="comments-list">
            {commentData}
        </div>
     );
}
 
export default withRouter(ShowComments);