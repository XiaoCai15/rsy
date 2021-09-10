package com.rsy.system.servlet;

import com.rsy.entity.Page;
import com.rsy.entity.Users;
import com.rsy.util.JdbcUtil;
import com.rsy.util.StringUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * 对用户user进行分页
 */
public class PageQueryUserServlet extends HttpServlet {
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       request.setCharacterEncoding("UTF-8");
       /**
        * 逻辑分页
        */
      //获取页码
       /* int pageno = request.getParameter("pageno") == null ? 1:Integer.parseInt(request.getParameter("pageno"));//Integer.parseInt(str) ;此处将str字符串转换为Integer型并存储到int类型的
       //获取session中的 大list集合
       HttpSession session = request.getSession();
       List<Users> bigList=(List<Users>) session.getAttribute("bigList");
        //如果为null 连接数据库
        if (bigList == null){
            bigList = new ArrayList<Users>();
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet result = null;

            JdbcUtil jdbcUtil = new JdbcUtil();
            try {

                String sql = "select usercode,username,orgtype from t_user order by regdate desc";
                ps = jdbcUtil.createStatement(sql);
                result = ps.executeQuery();
                while (result.next()){
                    Users users = new Users();
                    users.setUsercode(result.getString("usercode"));
                    users.setUesrname(result.getString("username"));
                    users.setOrgtype(result.getString("orgtype"));
                    bigList.add(users);
                    session.setAttribute("bigList",bigList);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }finally {
                jdbcUtil.close(result);
            }
        }
        //根据页码取小list数据
       List<Users> usersList = new ArrayList<Users>();
       int pagesize = 3;
       int beginIndex=pagesize *(pageno - 1);
        int endIndex=pagesize*pageno;
        if (endIndex > bigList.size()){
            endIndex = bigList.size();
        }
        for (int i=beginIndex;i<endIndex;i++){
            usersList.add(bigList.get(i));//当i=0时，取得是list集合中第一个元素
        }
       //将小list存到
        request.setAttribute("userList",usersList);
        request.getRequestDispatcher("/system/user.jsp").forward(request,response);
}*/

       /**
        * 物理分页
        */
       //创建Page
       Page<Users> page = new Page<Users>(request.getParameter("pageno"));

       //从配置文件中获取每页的记录条数
       page.setPagesize(Integer.parseInt(StringUtil.getTextBycode("pagesize")));


       int beginIndex = page.getPagesize() *(page.getPageno() - 1);
       int endIndex = page.getPagesize();

       PreparedStatement ps = null;
       ResultSet result = null;

       JdbcUtil jdbcUtil = new JdbcUtil();
       try {
           String sql = "select usercode,username,orgtype from t_user order by regdate desc limit ?,?";
           ps = jdbcUtil.createStatement(sql);
           ps.setInt(1,beginIndex);
           ps.setInt(2,endIndex);
           result = ps.executeQuery();
           while (result.next()){
               Users users = new Users();
               users.setUsercode(result.getString("usercode"));
               users.setUsername(result.getString("username"));
               users.setOrgtype(result.getString("orgtype"));
               //System.out.println(result.getString("usercode")+result.getString("username")+result.getString("orgtype"));
               //将数据存入list中
               page.getDataList().add(users);
           }
           //查询总条数
           sql = "select count(*) as totalsize from t_user";
           ps = jdbcUtil.createStatement(sql);
           result = ps.executeQuery();
           if(result.next()){
               page.setTotalsize(result.getInt("totalsize"));
           }
           System.out.println(page.getTotalsize());
           System.out.println(page.getPageCount());
           //总页数
        } catch (SQLException e) {
           e.printStackTrace();
        }finally {
            jdbcUtil.close(result);
       }

       //response.setContentType("text/html;charset=utf-8");

       //存储状态信息
     /*  request.setAttribute("pageno",   pageno);
       request.setAttribute("totalsize",totalsize);
       request.setAttribute("pageCount",pageCount);
       request.setAttribute("pagesize", pagesize);*/

        request.setAttribute("pageObj",page);
        request.getRequestDispatcher("/system/user.jsp").forward(request,response);
   }
}
