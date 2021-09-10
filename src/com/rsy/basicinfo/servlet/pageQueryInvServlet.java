package com.rsy.basicinfo.servlet;

import com.rsy.entity.Invest;
import com.rsy.entity.Page;
import com.rsy.entity.Users;
import com.rsy.util.JdbcUtil;
import com.rsy.util.StringUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class pageQueryInvServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        //创建Page
        Page<Invest> page = new Page<Invest>(request.getParameter("pageno"));
        int totalsize = 0; //总记录条数
        String invregnum = request.getParameter("invregnum");
        String invname = request.getParameter("invname");
        String startdate = request.getParameter("startdate");
        String enddate = request.getParameter("enddate");

        //从配置文件中获取每页的记录条数
        page.setPagesize(Integer.parseInt(StringUtil.getTextBycode("invpagesize")));
        //查询的初始位置
        int beginIndex = page.getPagesize() *(page.getPageno() - 1);
        int endIndex = page.getPagesize();
        PreparedStatement ps = null;
        ResultSet result = null;
        JdbcUtil jdbcUtil = new JdbcUtil();
        List<String> list = new ArrayList<String>();

        /*
         * where 1=1 作用占位 占据
         * StringBuilder 是可变的 初始容量是16
         */

        StringBuilder sql = new StringBuilder("select i.invregnum,i.invname,i.regdate,i.city,u.username from t_invest as i join t_user as u on i.usercode=u.usercode where 1=1 ");
        StringBuilder totalsizesql = new StringBuilder("select count(*) as totalsize from t_invest as i join t_user as u on i.usercode=u.usercode where 1=1 ");
        /*      if (StringUtil.isNotEmpty(invregnum)){
            sql.append("where invregnum ="+invregnum);
        }
       if (StringUtil.isNotEmpty(invname)){
            if (StringUtil.isNotEmpty(invregnum)){
                sql.append("and invname like '"+invname+"'");
            }else {
                sql.append("where invname like '%"+invname+"%'");
            }
        }
        if (StringUtil.isNotEmpty(startdate)){
            if (StringUtil.isNotEmpty(invregnum)||StringUtil.isNotEmpty(invname)){
                sql.append("and i.regdate >= "+startdate);
            }else {
                sql.append("where i.regdate >= "+startdate);
            }
        }
        if (StringUtil.isNotEmpty(enddate)){
            if (StringUtil.isNotEmpty(invregnum)||StringUtil.isNotEmpty(invname)||StringUtil.isNotEmpty(startdate)){
                sql.append("and  i.regdate <= "+enddate);
            }else {
            sql.append("where i.regdate <= "+enddate);
            }
        }*/
        /* //字符串拼接解决办法
       if (StringUtil.isNotEmpty(invregnum)){
            sql.append("and invregnum ="+invregnum);
        }
        if (StringUtil.isNotEmpty(invname)){
           sql.append("and invname like '%"+invname+"%'");
         }
        if (StringUtil.isNotEmpty(startdate)){
                sql.append("and i.regdate >= "+startdate);
         }
        if (StringUtil.isNotEmpty(enddate)){
            sql.append("and  i.regdate <= "+enddate);
        }*/

        /**
         * list集合解决办法
         */
        if (StringUtil.isNotEmpty(invregnum)){
            sql.append("and invregnum = ?");
            totalsizesql.append("and invregnum = ?");
            list.add(invregnum);
        }
        if (StringUtil.isNotEmpty(invname)){
            sql.append(" and invname like ?");
            totalsizesql.append("and invname like ?");
            list.add("%"+invname+"%");
        }
        if (StringUtil.isNotEmpty(startdate)){
            sql.append(" and i.regdate >= ?");
            totalsizesql.append("and i.regdate >= ?");
            list.add(startdate);
        }
        if (StringUtil.isNotEmpty(enddate)){
            sql.append(" and i.regdate <= ?");
            totalsizesql.append("and  i.regdate <= ?");
            list.add(enddate);
        }


        /*拼接分页limit*/
        sql.append(" order by i.regdate desc,i.invregnum desc limit ?,?");
        try {

            ps = jdbcUtil.createStatement(sql.toString());
            for (int i = 0; i < list.size(); i++){
                ps.setString(i+1, list.get(i));
            }
            ps.setInt(list.size()+1,beginIndex);
            ps.setInt(list.size()+2,endIndex);
            result = ps.executeQuery();
            while (result.next()){
                Invest invest = new Invest();

                invest.setInvregnum(result.getInt("invregnum"));
                invest.setInvname(result.getString("invname"));
                invest.setRegdate(result.getString("regdate"));
                invest.setCity(StringUtil.getTextBycode(result.getString("city")));
                invest.setUsername(result.getString("username"));
                //System.out.println(result.getString("usercode")+result.getString("invregnum")+result.getString("invname"));
                //将数据存入list中
                page.getDataList().add(invest);

            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            jdbcUtil.close(result);
        }
        /**
         * 总记录条数
         */
        try {
            ps = jdbcUtil.createStatement(totalsizesql.toString());
            for (int i = 0; i < list.size(); i++){
                ps.setString(i+1, list.get(i));
            }
            result = ps.executeQuery();
            if(result.next()){
                page.setTotalsize(result.getInt("totalsize"));
                System.out.println(page.getTotalsize());
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            jdbcUtil.close(result);
        }

        request.setAttribute("pageObj",page);
        //获取是哪个页面发送的 1-----投资人录入 2-----企业组织代码录入
       /* String goPage = request.getParameter("goPage");
        if ("1".equals(goPage)){
            request.getRequestDispatcher("/basicinfo/exoticOrgList.jsp").forward(request,response);
        }else if ("2".equals(goPage)){
            request.getRequestDispatcher("/foreignExchange/orgcodeSelect.jsp").forward(request,response);
        }*/
        request.getRequestDispatcher(request.getParameter("forward")).forward(request,response);


    }
}
