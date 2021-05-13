class API {
  /*------------------------------------------------------------
                          API URL
  -------------------------------------------------------------*/
  static const String API_URL =
      "https://api-nodejs-todolist.herokuapp.com";
  /*------------------------------------------------------------
                 API:Sign In and Sign Up
                 TYPE: post
  -------------------------------------------------------------*/
  static const Login = "$API_URL/user/login";
  static const Register = "$API_URL/user/register";
  static const addTask = "$API_URL/task";

}
