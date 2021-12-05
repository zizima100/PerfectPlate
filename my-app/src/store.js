import { configureStore } from '@reduxjs/toolkit'
import counterReducer from './store/Auth/AuthReducer'

export default configureStore({
    reducer: {
        userData: counterReducer,
    },
})
