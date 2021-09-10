package com.rsy.system.servlet;

import com.rsy.util.JdbcUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/*更新用户数据*/
public class doUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.setCharacterEncoding("UTF-8");

            String pageno = request.getParameter("pageno");
            String usercode = request.getParameter("usercode");
            String username = request.getParameter("username");
            String userpswd = request.getParameter("userpswd");
            String orgtype = request.getParameter("orgtype");

            PreparedStatement ps = null;
            int rs = 0;
            JdbcUtil jdbcUtil = new JdbcUtil();

            try {
                String sql = "update t_user set username=?,userpswd=?,orgtype=? where  usercode=?";
                ps = jdbcUtil.createStatement(sql);
                ps.setString(1,username);
                ps.setString(2,userpswd);
                ps.setString(3,orgtype);
                ps.setString(4,usercode);
                rs = ps.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }finally {
                jdbcUtil.close();
            }
            if (rs == 1){
                response.sendRedirect("/egov/servlet/PageQuery?pageno="+pageno);
            }
    }



}
