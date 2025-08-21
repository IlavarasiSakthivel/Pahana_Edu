import React from 'react';
import Sidebar from './Sidebar';
import { Outlet } from 'react-router-dom';

const Layout = ({ user }) => (
  <div style={{ display: 'flex' }}>
    <Sidebar user={user} />
    <main style={{ flex: 1 }}>
      <Outlet />
    </main>
  </div>
);

export default Layout;
