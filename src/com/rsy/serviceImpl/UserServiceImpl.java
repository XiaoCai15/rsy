package com.rsy.serviceImpl;

import com.rsy.dao.UserDao;
import com.rsy.daoImpl.UserDaoImpl;
import com.rsy.entity.Users;
import com.rsy.service.UserService;
import com.rsy.util.JdbcUtil;

import java.sql.Connection;
import java.sql.SQLException;

public class UserServiceImpl implements UserService {
    private static UserDao dao = new UserDaoImpl();
    @Override
    public Boolean selectByUsercode(String usercode) {
        /**
         * 获取connection
         *JdbcUtil util = new JdbcUtil();
         *         try {
         *             System.out.println(util.getCon());
         *         } catch (SQLException e) {
         *             e.printStackTrace();
         *         }
         */

        return dao.selectByUsercode(usercode);
    }

    @Override
    public int save(Users user) {
        int count = 0;
        count = dao.insertUser(user);
        return count;
    }
}
