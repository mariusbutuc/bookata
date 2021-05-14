import React, { useState, useEffect } from "react";
import { HashRouter, Switch, Route } from "react-router-dom";

import Nav from "./Nav";
import Profile from "./Profile";
import Protected from "./Protected";
import Public from "./Public";

const Router = () => {
  const [current, setCurrent] = useState("home");

  useEffect(() => {
    setRoute();
    // set up an event listener to call setRoute whenever the route changes
    window.addEventListener("hashchange", setRoute);
    return () => window.removeEventListener("hashchange", setRoute);
  }, []);

  function setRoute() {
    const location = window.location.href.split("/");
    const pathname = location[location.length - 1];
    setCurrent(pathname ? pathname : "home");
  }

  return (
    <HashRouter>
      <Nav current={current} />
      <Switch>
        <Route exact path="/" component={Public} />
        <Route exact path="/protected" component={Protected} />
        <Route exact path="/profile" component={Profile} />
      </Switch>
    </HashRouter>
  );
};

export default Router;
