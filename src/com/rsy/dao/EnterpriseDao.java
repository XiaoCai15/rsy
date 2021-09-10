package com.rsy.dao;

import com.rsy.entity.EnInv;
import com.rsy.entity.Enterprise;
import com.rsy.entity.Page;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface EnterpriseDao {
    int insert(Enterprise en, List<EnInv> list);
    Page<Enterprise> pageQuery(Map<String,String> map) throws SQLException;

    String makeCharXml(String orgcode) throws SQLException;
    Enterprise findByCode(String orgcode) throws SQLException;
}
