import React from 'react'
import {Route, IndexRoute} from 'react-router'
import App from './containers/App'
import Home from './pages/Home'
import NotFound from './pages/NotFound'
import SignUp from './pages/SignUp'
import SignIn from './pages/SignIn'
import discoveryRoutes from './modules/discovery/routes'

export default function createRoutes(dispatch) {
  return (
    <Route component={App} path='/'>
      <IndexRoute component={Home} />
      <Route component={SignUp} path='signup' />
      <Route component={SignIn} path='signin' />
      {discoveryRoutes('discovery', dispatch)}
      <Route component={NotFound} path='*' />
    </Route>
  );
}