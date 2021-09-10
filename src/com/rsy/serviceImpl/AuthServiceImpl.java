package com.rsy.serviceImpl;

import com.rsy.dao.AuthDao;
import com.rsy.daoImpl.AuthDaoImpl;
import com.rsy.entity.Auth;
import com.rsy.service.AuthService;
import com.rsy.util.JdbcUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

public class AuthServiceImpl implements AuthService {
    private static AuthDao authDao = new AuthDaoImpl();
    @Override
    public boolean saveAuth(Map<String, String> authMap) {
        Connection con = null;
        JdbcUtil jdbcUtil = new JdbcUtil();
        int count = 0;
        try {
            con = jdbcUtil.getCon();
            con.setAutoCommit(false);
            count = authDao.saveAuth(authMap);
            con.commit();
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }finally {
            jdbcUtil.close(con);
        }
        return count == 1;
    }

    @Override
    public Auth findByAuthno(String authno) {
        Auth auth = null;
        JdbcUtil util = new JdbcUtil();
        Connection con = null;
        try {
            con = util.getCon();
            con.setAutoCommit(false);
            auth  = authDao.findByAuthno(authno);
            con.commit();
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }finally {
            util.close(con);
        }
        return auth;
    }

    @Override
    public int upFeedBack(String authno) {
        Connection con = null;
        JdbcUtil jdbcUtil = new JdbcUtil();
        int count = 0;
        try {
            con = jdbcUtil.getCon();
            con.setAutoCommit(false);
            count = authDao.upFeedBack(authno);
            con.commit();
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }finally {
            jdbcUtil.close(con);
        }
        return count;
    }
}
