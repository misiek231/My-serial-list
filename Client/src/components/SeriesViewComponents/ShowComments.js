import React, { useEffect, useContext } from 'react';
import { withRouter } from 'react-router-dom';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import { CommentsContext } from '../../contexts/GetCommentsContext';
import uuid from 'uuid/v1';
import { getComments } from '../../actions/getComments';

const ShowComments = (props) => {
    const {compulsoryData} = useContext(CompulsoryContext);
    const {comments, dispatch} = useContext(CommentsContext)
    useEffect(() =>{
       getComments(compulsoryData.ip, dispatch, props.match.params.id);
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