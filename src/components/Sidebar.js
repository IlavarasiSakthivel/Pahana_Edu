import React from 'react';
import { NavLink } from 'react-router-dom';

const Sidebar = ({ user }) => {
  return (
    <aside style={{ width: 200, background: '#eee', minHeight: '100vh' }}>
      <h2>Sidebar</h2>
      {user.role === 'admin' ? (
        <ul>
          <li>
            <NavLink to="/admin-dashboard">Admin Dashboard</NavLink>
          </li>
          {/* Add more admin links as needed */}
        </ul>
      ) : user.role === 'staff' ? (
        <ul>
          <li>
            <NavLink to="/staff_dashboard">Staff Dashboard</NavLink>
          </li>
          {/* Add more staff links as needed */}
        </ul>
      ) : (
        <ul>
          <li>
            <NavLink to="/dashboard">Dashboard</NavLink>
          </li>
          {/* Add more user links as needed */}
        </ul>
      )}
    </aside>
  );
};

export default Sidebar;
