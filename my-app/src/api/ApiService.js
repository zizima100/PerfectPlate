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

  return {
    userLogin,
    userRegister,
    getAllPlates
  };
}
