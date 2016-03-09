package com.infosys.ocj.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;

import com.infosys.ocj.utils.RequestPager;
import com.infosys.ocj.dao.ICustomerDao;
import com.infosys.ocj.pojo.Customer;

public class CustomerDaoImpl implements ICustomerDao {
	private SqlSession session;
	
	
	
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<Customer> getList(RequestPager pager) {
		 HashMap<String, Integer> map = new HashMap<String,Integer>();
		 map.put("end", pager.getRows());
		 map.put("begin", (pager.getPage()-1)*pager.getRows());
		return this.session.selectList("customer.list",map);
	}
	
	@Override
	public void add(Customer customer) {
		UUID uuid = UUID.randomUUID();
		customer.setId(uuid.toString());
		this.session.insert("customer.add",customer);
		
	}

	@Override
	public void update(Customer customer) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(String id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Map<String,String>> graph() {
		return this.session.selectList("customer.graph");
	}

	@Override
	public List<Customer> search(HashMap<String, String> condition) {
		return this.session.selectList("customer.search",condition);
	}

	@Override
	public int getTotal() {
		return (int)this.session.selectOne("customer.total");
		
	}




}
