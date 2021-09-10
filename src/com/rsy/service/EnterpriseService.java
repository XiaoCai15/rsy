package com.rsy.service;

import com.rsy.entity.EnInv;
import com.rsy.entity.Enterprise;
import com.rsy.entity.Page;

import java.util.List;
import java.util.Map;

public interface EnterpriseService {
    boolean saveEnterprise(Enterprise en, List<EnInv> list);
    Page<Enterprise> pageQuery(Map<String,String> map);

    String makeCharXml(String orgcode);
    Enterprise findByCode(String orgcode);
}
