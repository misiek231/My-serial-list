export const oneSeriesReducer = (state,action) =>{
    switch(action.type){
        case 'SET_SERIES':
            return{
                ...state,
                oneSeries:{
                    ...state.oneSeries,
                    title: action.oneSeries.title,
                    genre: action.oneSeries.genre,
                    released: action.oneSeries.released,
                    filmProductionId: action.oneSeries.filmProductionId,
                    poster: action.oneSeries.poster,
                    plot: action.oneSeries.plot,
                    votes: action.oneSeries.votes,
                    rating: action.oneSeries.rating,
                    isSeries: action.oneSeries.isSeries
                }
            }
        default:
            return state;
    }
}