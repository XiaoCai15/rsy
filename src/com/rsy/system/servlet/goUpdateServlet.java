package com.rsy.system.servlet;

import com.rsy.entity.Users;
import com.rsy.util.JdbcUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Result;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 跳转到修改用户信息页面
 * 使用用户代码获取其全部信息
 */
public class goUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String usercode = request.getParameter("usercode");
       // System.out.println(usercode);
        JdbcUtil jdbcUtil = new JdbcUtil();
        PreparedStatement ps = null;
        ResultSet rs =null;
        Users user =null;
        try {
            String sql = "select username,userpswd,orgtype from t_user where usercode=?";
            ps = jdbcUtil.createStatement(sql);
            ps.setString(1,usercode);
            rs = ps.executeQuery();


            if (rs.next()){
                user = new Users();
                user.setUsercode(usercode);
                user.setUsername(rs.getString("username"));
                user.setOrgtype(rs.getString("orgtype"));
                user.setUserpswd(rs.getString("userpswd"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            jdbcUtil.close(rs);
        }
        request.setAttribute("user",user);
        request.getRequestDispatcher("/system/userUpdate.jsp").forward(request,response);
    }


}
