import { createSlice } from '@reduxjs/toolkit'

export const counterSlice = createSlice({
  name: 'userData',
  initialState: {
    id: 0,
  },
  reducers: {
    setId: (state, action) => {
      state.id = action.payload;
    },
  },
})

export const { setId } = counterSlice.actions

export default counterSlice.reducer
