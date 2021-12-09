import apisauce from "apisauce";

const baseURL = "https://perfect-plate.herokuapp.com";

export default function create() {
  function apiCallHeaders() {
    return {
      headers: {
        "Cache-Control": "no-cache",
        "Content-Type": "application/json",
        Accept: "application/json",
      },
    };
  }

  const apiCall = apisauce.create({
    baseURL,
  });

  function userLogin(email, password) {
    return apiCall.post("/users/login", {email, password}, apiCallHeaders());
  }

  function userDataById(userId) {
    return apiCall.get(`/user?user_id=${userId}`, apiCallHeaders());
  }

  function putUserData(data) {
    return apiCall.put(`/user/edit`, data, apiCallHeaders());
  }

  function userRegister(data) {
    return apiCall.post("/users/signup", data, apiCallHeaders());
  }

  function getAllPlates(userId) {
    return apiCall.get(`/plates/query_all?user_id=${userId}`, apiCallHeaders());
  }

  function getPlateById(plateId) {
    return apiCall.get(`/plate?plate_id=${plateId}`, apiCallHeaders());
  }

  function deletePlateById(plateId) {
    return apiCall.delete(`/plate/delete?plate_id=${plateId}`, apiCallHeaders());
  }

  function getAllIngredients() {
    return apiCall.get("/ingredients/query_all", apiCallHeaders());
  }

  function insertIngredient(data) {
    return apiCall.post("/ingredient/create", data, apiCallHeaders());
  }

  function insertPlate(data) {
    return apiCall.post("/plates/plate/insert", data, apiCallHeaders());
  }

  function insertIngredientToPlate(data) {
    return apiCall.post("/plates/ingredient/insert", data, apiCallHeaders());
  }

  function insertIngredientSuggestion(data) {
    return apiCall.post("/ingredient/suggestion", data, apiCallHeaders());
  }

  function getIngredientSuggestions() {
    return apiCall.get("/ingredient/suggestion-list", apiCallHeaders());
  }

  function deleteIngredientSuggestion(suggestionId) {
    return apiCall.delete(`/ingredient/suggestion/delete?ingredient_id=${suggestionId}`, apiCallHeaders());
  }

  return {
    userLogin,
    userDataById,
    putUserData,
    userRegister,
    getAllPlates,
    insertIngredient,
    getPlateById,
    deletePlateById,
    getAllIngredients,
    insertPlate,
    insertIngredientToPlate,
    insertIngredientSuggestion,
    getIngredientSuggestions,
    deleteIngredientSuggestion
  };
}
