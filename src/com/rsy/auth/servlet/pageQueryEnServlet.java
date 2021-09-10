package com.rsy.auth.servlet;

import com.rsy.entity.Enterprise;
import com.rsy.entity.Page;
import com.rsy.service.EnterpriseService;
import com.rsy.serviceImpl.EnterpriseServiceImpl;


import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 分页查询企业信息
 */
public class pageQueryEnServlet extends HttpServlet {
    private static EnterpriseService en = new EnterpriseServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orgcode = request.getParameter("orgcode");
        String cnname = request.getParameter("cnname");
        String startdate = request.getParameter("startdate");
        String endtdate = request.getParameter("endtdate");
        String pageno =request.getParameter("pageno");

        Map<String,String> conditionMap = new HashMap<String,String>();
        conditionMap.put("orgcode",orgcode);
        conditionMap.put("cnname",cnname);
        conditionMap.put("startdate",startdate);
        conditionMap.put("endtdate",endtdate);
        conditionMap.put("pageno",pageno);

        Page<Enterprise> page = en.pageQuery(conditionMap);
        request.setAttribute("page",page);
        request.getRequestDispatcher("/auth/orgcodeSelect.jsp").forward(request,response);
    }
}
