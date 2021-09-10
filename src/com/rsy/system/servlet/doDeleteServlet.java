package com.rsy.system.servlet;

import com.rsy.util.JdbcUtil;
import com.sun.xml.internal.ws.policy.EffectiveAlternativeSelector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * 删除用户数据
 */
public class doDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String[] usercodes =request.getParameterValues("usercode");

        Connection con = null;
        PreparedStatement ps = null;
        //int rs = 0;
        boolean issuccess = true;
        JdbcUtil jdbcUtil = new JdbcUtil();


        try {
            String sql = "delete from t_user where usercode = ?";
            con = jdbcUtil.getCon();
            //开启事务 对表文件备份
            con.setAutoCommit(false);
            ps = jdbcUtil.createStatement(con,sql);

            for (String usercode:usercodes){
                ps.setString(1,usercode);
                //rs +=ps.executeUpdate();
                /**
                 * 批处理
                 * addBatch------->打包
                 * executeBath---->发送
                 * clareBath------>清空包
                 */
                ps.addBatch();

            }
            ps.executeBatch();

            con.commit();//对表文件备份进行删除
        } catch (SQLException e) {
            issuccess = false;
            try {
                con.rollback();//事务回滚 本次操作中所有表文件备份覆盖表文件，取消本次操作
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();


        }finally {
            try {
                con.setAutoCommit(true);//结束事务让其回到原始状态
            } catch (SQLException e) {
                e.printStackTrace();
            }
            jdbcUtil.close();
        }
        /*if (rs == usercodes.length){
            response.sendRedirect("/egov/PageQuery");
        }*/
        if (issuccess){
            response.sendRedirect("/egov/servlet/PageQuery");
        }
    }


}
