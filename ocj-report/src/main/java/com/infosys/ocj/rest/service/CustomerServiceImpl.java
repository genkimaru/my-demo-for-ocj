package com.infosys.ocj.rest.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.ws.rs.WebApplicationException;

import com.infosys.ocj.dao.ICustomerDao;
import com.infosys.ocj.pojo.Customer;
import com.infosys.ocj.utils.RequestPager;
import com.infosys.ocj.ws.ICustomerService;

public class CustomerServiceImpl implements ICustomerService {

	private ICustomerDao customerDao;
	
	public void setCustomerDao(ICustomerDao customerDao) {
		this.customerDao = customerDao;
	}
	
	@Override
	public HashMap<String,Object> list(int p, int r) throws WebApplicationException {
		// TODO Auto-generated method stub
		RequestPager pager = new RequestPager();
		pager.setPage(p);
		pager.setRows(r);
		 List<Customer> list = customerDao.getList(pager);
		 int total = customerDao.getTotal();
		 HashMap<String, Object> map = new HashMap<String,Object>();
		 map.put("rows",list );
		 map.put("total",total );
		 return map;
	}



	@Override
	public void add(Customer customer)
			throws WebApplicationException {
		// TODO Auto-generated method stub

		 customerDao.add(customer);
	}

	@Override
	public Map<String, Object> delete(HashMap<String, Object> map)
			throws WebApplicationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> update(HashMap<String, Object> map)
			throws WebApplicationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String,String>> graph() throws WebApplicationException {
		
		return customerDao.graph();
	}


	@Override
	public List<Customer> search(String address, String gender)
			throws WebApplicationException {
		HashMap<String,String> condition = 	new 	HashMap<String,String>();
		condition.put("address", address);
		condition.put("gender", gender);
		return customerDao.search(condition);
	}




}
