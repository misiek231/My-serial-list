import React, { useState } from 'react'
import { Input, Button, Divider } from 'antd';

const AddComment = () => {
    const [commentData, setCommentData] = useState({
        commentValue: '',
        submitting: false
    })

    const {TextArea} = Input;

    const handleSubmit = () =>{
        setCommentData({...commentData, submitting: true})
    }

    const handleChange = (e) =>{
       setCommentData({...commentData, commentValue: e.target.value});
    }

    console.log(commentData);

    return ( 
        <div className="addComment">
             <Divider style={{color: '#fff'}}>Sekcja komentarzy</Divider>
            <TextArea
                autosize = {{ minRows: 2, maxRows: 6 }}
                placeholder = 'Podziel się opinią'
                onChange = {handleChange}
                style={{fontSize: '16px'}}
            />
            <Button htmlType="submit" loading={commentData.submitting} onClick={handleSubmit} className="submitButton">
                Dodaj opinię
            </Button>
        </div>
     );
}
 
export default AddComment;