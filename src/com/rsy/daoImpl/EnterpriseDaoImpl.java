package com.rsy.daoImpl;

import com.rsy.dao.EnterpriseDao;
import com.rsy.entity.EnInv;
import com.rsy.entity.Enterprise;
import com.rsy.entity.Invest;
import com.rsy.entity.Page;
import com.rsy.util.JdbcUtil;
import com.rsy.util.StringUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 企业相关的
 *
 */
public class EnterpriseDaoImpl implements EnterpriseDao {
    /**
     * 添加企业信息与投资人
     * @param ent 企业信息
     * @param list 投资人
     * @return
     */
    @Override
    public int insert(Enterprise ent, List<EnInv> list) {
        Connection con = null;
        PreparedStatement ps = null;
        int rs = 0;
        JdbcUtil jdbcUtil = new JdbcUtil();

        try {
            String sql ="insert into t_enterprise(orgcode,regno,cnname,enname,contactman,contacttel,regcap,outregcap,regcry,usercode,regdate) values(?,?,?,?,?,?,?,?,?,?,?)";
            ps = jdbcUtil.createStatement(sql);
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
            ps = jdbcUtil.createStatement(sql);
            for (EnInv enInv:list){
                ps.setString(1,ent.getOrgcode());
                ps.setString(2,enInv.getInvregnums());
                ps.setInt(3,enInv.getRegcapItems());
                ps.setInt(4,enInv.getScales());
                rs += ps.executeUpdate();
            }

        } catch (SQLException e) {
           e.printStackTrace();
            throw new RuntimeException("保存企业失败");
        }finally {
            jdbcUtil.close(ps);
        }

        return rs;
    }

    /**
     * 分页查询企业信息
     * @param map
     * @return
     * @throws SQLException
     */
    @Override
    public Page<Enterprise> pageQuery(Map<String, String> map) throws SQLException {
        Page<Enterprise> page = new Page<>(map.get("pageno"));
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet result = null;
        JdbcUtil jdbcUtil = new JdbcUtil();
        List<String> list = new ArrayList<>();

        page.setPagesize(Integer.parseInt(StringUtil.getTextBycode("invpagesize")));
        int beginIndex = page.getPagesize() *(page.getPageno() - 1);
        int endIndex = page.getPagesize();

        StringBuilder sql = new StringBuilder("select e.orgcode,e.cnname,e.regdate,u.username from t_enterprise as e join t_user as u on e.usercode=u.usercode where 1=1 ");
        StringBuilder totalsizesql = new StringBuilder("select count(*) as totalsize from t_enterprise as e join t_user as u on e.usercode=u.usercode where 1=1 ");

        if (StringUtil.isNotEmpty(map.get("orgcode"))){
            sql.append("and orgcode = ?");
            totalsizesql.append("and orgcode = ?");
            list.add(map.get("orgcode"));
        }
        if (StringUtil.isNotEmpty(map.get("cnname"))){
            sql.append(" and cnname like ?");
            totalsizesql.append("and cnname like ?");
            list.add("%"+map.get("cnname")+"%");
        }
        if (StringUtil.isNotEmpty(map.get("startdate"))){
            sql.append(" and e.regdate >= ?");
            totalsizesql.append("and i.regdate >= ?");
            list.add(map.get("startdate"));
        }
        if (StringUtil.isNotEmpty(map.get("endtdate"))){
            sql.append(" and e.regdate <= ?");
            totalsizesql.append("and  e.regdate <= ?");
            list.add(map.get("endtdate"));
        }
        sql.append(" order by e.regdate desc,e.cnname desc limit ?,?");

        ps = jdbcUtil.createStatement(sql.toString());
        for (int i = 0; i < list.size(); i++){
            ps.setString(i+1, list.get(i));
        }
        ps.setInt(list.size()+1,beginIndex);
        ps.setInt(list.size()+2,endIndex);
        result = ps.executeQuery();
        while (result.next()){
            Enterprise enterprise = new Enterprise();

            enterprise.setOrgcode(result.getString("orgcode"));
            enterprise.setCnname(result.getString("cnname"));
            enterprise.setRegdate(result.getString("regdate"));
            enterprise.setUsername(result.getString("username"));
            //System.out.println(result.getString("usercode")+result.getString("invregnum")+result.getString("invname"));
            //将数据存入list中
            page.getDataList().add(enterprise);
        }

        ps = jdbcUtil.createStatement(totalsizesql.toString());
        for (int i = 0; i < list.size(); i++){
            ps.setString(i+1, list.get(i));
        }
        result = ps.executeQuery();
        if(result.next()){
            page.setTotalsize(result.getInt("totalsize"));
            //System.out.println(page.getTotalsize());
        }

        jdbcUtil.close(ps);

        return page;
    }

    /**
     * 企业信息分页查询上的统计图表
     * @param orgcode
     * @return
     */
    @Override
    public String makeCharXml(String orgcode) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet result = null;
        JdbcUtil jdbcUtil = new JdbcUtil();

        //拼接xml
        StringBuilder charXml = new StringBuilder();
        charXml.append("<?xml versoin='1.0' encoding='Utf-8'?>");
        charXml.append("<graph showNames='1'  decimalPrecision='0'  > ");

        String sql = "select i.invname,ei.regcapItem from t_invest as i join t_en_inv as ei on i.invregnum=ei.invregnum where  ei.orgcode=? ";
        ps = jdbcUtil.createStatement(sql);
        ps.setString(1,orgcode);
        result = ps.executeQuery();

        while (result.next()){
            charXml.append("<set name='"+result.getString("invname")+"' value='"+result.getString("regcapItem")+"'/>");
        }

        charXml.append("</graph>");
        jdbcUtil.close(ps);
        return charXml.toString();
    }

    /**
     * 查询企业明细
     * @param orgcode
     * @return
     */
    @Override
    public Enterprise findByCode(String orgcode) throws SQLException {
        Enterprise en = new Enterprise();
        PreparedStatement ps = null;
        ResultSet result = null;
        JdbcUtil jdbcUtil = new JdbcUtil();

        String sql = "select cnname,regcry,regcap from t_enterprise where orgcode=?";
        ps = jdbcUtil.createStatement(sql);
        ps.setString(1,orgcode);
        result = ps.executeQuery();
        while (result.next()){
            en.setOrgcode(orgcode);
            en.setCnname(result.getString("cnname"));
            en.setRegcry(result.getString("regcry"));
            en.setRegcap(result.getString("regcap"));
        }
        jdbcUtil.close(ps);
        return en;
    }

}
