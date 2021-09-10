package com.rsy.foreignExchange.servlet;

import com.rsy.entity.EnInv;
import com.rsy.entity.Enterprise;
import com.rsy.entity.Users;
import com.rsy.service.EnterpriseService;
import com.rsy.serviceImpl.EnterpriseServiceImpl;
import com.rsy.util.Const;
import com.rsy.util.DateUtil;
import com.rsy.util.JdbcUtil;
import com.rsy.util.WebUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 添加企业
 */
public class orgAddServlet extends HttpServlet {
    private static EnterpriseService en = new EnterpriseServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //企业信息
        Enterprise ent = new Enterprise();
        WebUtil.makeRequestToObject(request,ent);
        ent.setUsercode(((Users) request.getSession(false).getAttribute("user")).getUsercode());
        ent.setRegdate(DateUtil.format(new Date(), Const.DATE_FORMAT_YMD));
        //企业投资人信息
        String[] invregnums = request.getParameterValues("invregnum");
        String[] regcapItems = request.getParameterValues("regcapItem");
        String[] scales = request.getParameterValues("scale");
        //遍历数组封装EnInv对象，存储到List集合中
        List<EnInv> list = new ArrayList<EnInv>();
        for (int i=0;i<invregnums.length;i++){
            EnInv enInv = new EnInv();
            enInv.setInvregnums(invregnums[i]);
            enInv.setRegcapItems(Integer.parseInt(regcapItems[i]));
            enInv.setScales(Integer.parseInt(scales[i]));
            list.add(enInv);
        }

        boolean saveSuccess = en.saveEnterprise(ent,list);
        if (saveSuccess){
            request.getRequestDispatcher("/foreignExchange/newInputOrg.jsp").forward(request,response);

        }
       /* //连接数据库
        Connection con = null;
        PreparedStatement ps = null;
        int rs = 0;
        JdbcUtil jdbcUtil = new JdbcUtil();

        try {
            con = jdbcUtil.getCon();
            con.setAutoCommit(false);
            String sql ="insert into t_enterprise(orgcode,regno,cnname,enname,contactman,contacttel,regcap,outregcap,regcry,usercode,regdate) values(?,?,?,?,?,?,?,?,?,?,?)";
            ps = jdbcUtil.createStatement(con,sql);
            ps.setString(1,ent.getOrgcode());
            ps.setString(2,ent.getRegno());
            ps.setString(3,ent.getCnname());
            ps.setString(4,ent.getEnname());
            ps.setString(5,ent.getContactman());
            ps.setString(6,ent.getContacttel());
            ps.setInt(7,Integer.parseInt(ent.getRegcap()));
            ps.setInt(8,Integer.parseInt(ent.getOutregcap()));
            ps.setString(9,ent.getRegcry());
            ps.setString(10,ent.getUsercode());
            ps.setString(11,ent.getRegdate());
            rs = ps.executeUpdate();

            sql = "insert into t_en_inv(orgcode,invregnum,regcapItem,scale) values (?,?,?,?)";
            ps = jdbcUtil.createStatement(con,sql);
            for (int i=0;i<invregnums.length;i++){
                ps.setString(1,ent.getOrgcode());
                ps.setString(2,invregnums[i]);
                ps.setInt(3,Integer.parseInt(regcapItems[i]));
                ps.setInt(4,Integer.parseInt(scales[i]));
                rs += ps.executeUpdate();
            }
            con.commit();
        } catch (SQLException throwables) {
            try {
                con.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            throwables.printStackTrace();
        }finally {
            jdbcUtil.close();
        }
        if(rs == 1+invregnums.length){
            request.getRequestDispatcher("/foreignExchange/newInputOrg.jsp").forward(request,response);
        }*/

    }
}
