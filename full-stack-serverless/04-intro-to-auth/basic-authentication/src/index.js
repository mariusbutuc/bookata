import React from "react";
import ReactDOM from "react-dom";
import Router from "./Router";

import "./index.css";
import "antd/dist/antd.css";

import Amplify from "aws-amplify";
import config from "./aws-exports";
Amplify.configure(config);

ReactDOM.render(<Router />, document.getElementById("root"));
