import { createSlice } from '@reduxjs/toolkit'

export const counterSlice = createSlice({
  name: 'userData',
  initialState: {
    id: 0,
    userType: "PADRAO"
  },
  reducers: {
    setId: (state, action) => {
      state.id = action.payload;
    },
    setUserType: (state, action) => {
      state.userType = action.payload;
    },
  },
})

export const { setId, setUserType } = counterSlice.actions

export default counterSlice.reducer
