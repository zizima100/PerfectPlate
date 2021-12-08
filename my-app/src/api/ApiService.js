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

  function userRegister(data) {
    return apiCall.post("/users/signup", data, apiCallHeaders());
  }

  function getAllPlates(userId) {
    return apiCall.get(`/plates/query_all?user_id=${userId}`, apiCallHeaders());
  }

  function getPlateById(plateId) {
    return apiCall.get(`/plate?plate_id=${plateId}`, apiCallHeaders());
  }

  function getAllIngredients() {
    return apiCall.get("/ingredients/query_all", apiCallHeaders());
  }

  function insertPlate(data) {
    return apiCall.post("/plates/plate/insert", data, apiCallHeaders());
  }

  function insertIngredientToPlate(data) {
    return apiCall.post("/plates/ingredient/insert", data, apiCallHeaders());
  }

  return {
    userLogin,
    userRegister,
    getAllPlates,
    getPlateById,
    getAllIngredients,
    insertPlate,
    insertIngredientToPlate
  };
}
