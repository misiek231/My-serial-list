import React, { useState, useContext } from 'react'
import { Input, Button, Divider } from 'antd';
import { withRouter } from 'react-router-dom';
import axios from 'axios';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';

const AddComment = (props) => {
    const [commentData, setCommentData] = useState({
        commentValue: '',
        submitting: false
    })

    const {compulsoryData} = useContext(CompulsoryContext);

    const {TextArea} = Input;

    const handleSubmit = () =>{
        setCommentData({...commentData, submitting: true})
        axios.post(compulsoryData.ip + '/api/ReviewFilmProduction/add_comment', {
            filmProductionId: props.match.params.id,
            description: commentData.commentValue
        })
        .then(res =>{
        })
        .catch(err =>{

        })
    }

    const handleChange = (e) =>{
       setCommentData({...commentData, commentValue: e.target.value});
    }


    return ( 
        <div className="addComment">
             <Divider style={{color: '#fff'}}>Sekcja komentarzy</Divider>
             <div className="addComment-content">
                <TextArea
                    autosize = {{ minRows: 2, maxRows: 6 }}
                    placeholder = 'Podziel się opinią'
                    onChange = {handleChange}
                    style={{fontSize: '14px'}}
                />
                <Button htmlType="submit" loading={commentData.submitting} onClick={handleSubmit} className="submitButton">
                    Dodaj opinię
                </Button>
            </div>
        </div>
     );
}
 
export default withRouter(AddComment);