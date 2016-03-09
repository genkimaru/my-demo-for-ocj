package com.infosys.ocj.ws;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;

import com.infosys.ocj.pojo.Customer;
import com.infosys.ocj.utils.RequestPager;

@Path("/customer")
public interface ICustomerService {

	@Path("list")
	@POST
	@Produces(value = {MediaType.APPLICATION_JSON })
	@Consumes(value = { MediaType.APPLICATION_FORM_URLENCODED })
	HashMap<String,Object> list( @FormParam("page") int p,
			@FormParam("rows") int r ) throws WebApplicationException;

	@Path("add")
	@POST
	@Produces(value = { MediaType.APPLICATION_JSON })
	void  add(Customer customer)
			throws WebApplicationException;

	@Path("delete")
	@DELETE
	@Produces(value = { MediaType.APPLICATION_JSON })
	Map<String, Object> delete(HashMap<String, Object> map)
			throws WebApplicationException;

	@Path("update")
	@PUT
	@Produces(value = { MediaType.APPLICATION_JSON })
	Map<String, Object> update(HashMap<String, Object> map)
			throws WebApplicationException;
	
	@Path("graph")
	@GET
	@Produces(value = {MediaType.APPLICATION_JSON })
	List<Map<String,String>> graph() throws WebApplicationException;
	
	@Path("search")
	@POST
	@Produces(value = {MediaType.APPLICATION_JSON })
	List<Customer> search(@FormParam("address") String address,@FormParam("gender") String gender) throws WebApplicationException;

}
