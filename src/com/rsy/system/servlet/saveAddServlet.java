package com.rsy.system.servlet;

import com.rsy.entity.Users;
import com.rsy.service.UserService;
import com.rsy.serviceImpl.UserServiceImpl;
import com.rsy.util.Const;
import com.rsy.util.DateUtil;
import com.rsy.util.JdbcUtil;
import com.rsy.util.WebUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 * 新增user
 */
public class saveAddServlet extends HttpServlet {
    private static  UserService service = new UserServiceImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int count = 0;

        Users user = new Users();
        WebUtil.makeRequestToObject(request,user);
        user.setRegdate(DateUtil.format(new Date(), Const.DATE_FORMAT_ALL));
        System.out.println(user.getUserpswd());
        System.out.println(user.getUesrname());
        System.out.println(user.getUsercode());
        System.out.println(user.getOrgtype());
        count = service.save(user);


        if(count == 1){
                response.sendRedirect("/egov/servlet/PageQuery");//保存成功再分页查询
            }

    }


}
