package com.infosys.ocj.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.infosys.ocj.pojo.Customer;
import com.infosys.ocj.utils.RequestPager;



public interface ICustomerDao {
	public int getTotal();

	public List<Customer> getList(RequestPager pager);

	public void add(Customer customer);
	
	public void update(Customer customer);
	
	public void delete(String id);

	public List<Map<String,String>> graph();

	public List<Customer> search(HashMap<String, String> condition);
	
	
}
