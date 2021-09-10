package com.rsy.daoImpl;

import com.rsy.dao.UserDao;
import com.rsy.entity.Users;
import com.rsy.util.JdbcUtil;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDaoImpl implements UserDao {
    @Override
    public Boolean selectByUsercode(String usercode) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean flag = false;

        JdbcUtil util = new JdbcUtil();
        try {
            System.out.println(util.getCon());
            String sql = "select * from t_user where usercode=?";
            ps = util.createStatement(sql);
            ps.setString(1,usercode);
            rs = ps.executeQuery();
            flag = rs.next();


        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException();
        }finally {
            util.close(rs);
        }
        return flag;
    }

    @Override
    public int insertUser(Users user) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        JdbcUtil util = new JdbcUtil();

        try {

            String  sql = "insert into t_user(usercode,username,userpswd,orgtype,regdate) values(?,?,?,?,?)";
            ps = util.createStatement(sql);
            ps.setString(1,user.getUsercode());
            ps.setString(2,user.getUesrname());
            ps.setString(3,user.getUserpswd());
            ps.setString(4,user.getOrgtype());
            ps.setString(5,user.getRegdate());
            count = ps.executeUpdate();
        }catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException();
        }finally {
            util.close();
        }
        return count;
    }
}
