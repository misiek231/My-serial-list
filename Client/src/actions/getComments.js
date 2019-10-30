import { setComments } from "./setCommentsAction";
import axios from 'axios';

export const getComments = (ip, dispatch, id) =>{
    axios.get(ip + '/api/ReviewFilmProduction/get_comments/' + id)
    .then(res =>{
        dispatch(setComments(res.data))
    })
    .catch(err =>{
        console.error(err);
    })
}