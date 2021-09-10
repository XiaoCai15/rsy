package com.rsy.serviceImpl;

import com.rsy.dao.EnterpriseDao;
import com.rsy.daoImpl.EnterpriseDaoImpl;
import com.rsy.entity.EnInv;
import com.rsy.entity.Enterprise;
import com.rsy.entity.Page;
import com.rsy.service.EnterpriseService;
import com.rsy.util.JdbcUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * 企业相关的
 *
 */
public class EnterpriseServiceImpl implements EnterpriseService {
    private static EnterpriseDao dao = new EnterpriseDaoImpl();

    /**
     * 添加企业信息与投资人
     * @param en 企业信息
     * @param list 投资人
     * @return
     */
    @Override
    public boolean saveEnterprise(Enterprise en, List<EnInv> list) {
        JdbcUtil util = new JdbcUtil();
        Connection con = null;
        int count = 0;
        try {
            con = util.getCon();
            con.setAutoCommit(false);
            count = dao.insert(en,list);
            con.commit();
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }finally {
            util.close(con);
        }
        return count == 1 + list.size();
    }

    /**
     * 分页查询企业信息
     * @param map
     * @return
     */
    @Override
    public Page<Enterprise> pageQuery(Map<String,String> map) {
        JdbcUtil util = new JdbcUtil();
        Connection con = null;
        Page<Enterprise> page = null;
        try {
            con = util.getCon();
            con.setAutoCommit(false);
            page = dao.pageQuery(map);
            con.commit();
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }finally {
            util.close(con);
        }
        return page;
    }

    /**
     * 企业信息分页查询上的统计图表
     * @param orgcode
     * @return
     */
    @Override
    public String makeCharXml(String orgcode) {
        JdbcUtil util = new JdbcUtil();
        Connection con = null;
        String charXml = null;
        try {
            con = util.getCon();
            con.setAutoCommit(false);
            charXml = dao.makeCharXml(orgcode);
            con.commit();
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }finally {
            util.close(con);
        }

        return charXml;
    }

    /**
     * 查询企业明细
     * @param orgcode
     * @return
     */
    @Override
    public Enterprise findByCode(String orgcode) {
        JdbcUtil jdbcUtil = new JdbcUtil();
        Connection con = null;
        Enterprise ent = null;
        try {
            con = jdbcUtil.getCon();
            con.setAutoCommit(false);
            ent = dao.findByCode(orgcode);
            con.commit();
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }finally {
            jdbcUtil.close(con);
        }
        return ent;
    }


}
