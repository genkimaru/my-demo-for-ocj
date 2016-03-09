package com.infosys.ocj.action;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;




import com.infosys.ocj.dao.ICustomerDao;
import com.infosys.ocj.pojo.Customer;

@Controller
public class CustomerAction {

	
//	// 业务方法 -- 模板下载
//	public String download() {
//		return "downloadSUCCESS";
//	}
//
//	public String getDownloadFileName() throws IOException {
//		String filename = "工作单导入模板.xls";
//		return FileUtils.encodeDownloadFilename(filename, getRequest()
//				.getHeader("user-agent"));
//	}
//
//	public InputStream getInputStream() throws Exception {
//		String path = ServletActionContext.getServletContext().getRealPath(
//				"/WEB-INF/document/工作单导入模板.xls");
//		return new FileInputStream(path);
//	}

	@Resource
	private ICustomerDao customerDao;
	


	@RequestMapping(value = "/batchImport")
	@ResponseBody
	public String batchImport(@RequestParam MultipartFile myfile, HttpServletRequest request) throws Exception {
		
		if(myfile.isEmpty()){  
            System.out.println("文件未上传");  
        }else{  
            System.out.println("文件长度: " + myfile.getSize());  
            System.out.println("文件类型: " + myfile.getContentType());  
            System.out.println("文件名称: " + myfile.getName());  
            System.out.println("文件原名: " + myfile.getOriginalFilename());  
            System.out.println("========================================");  
            //如果用的是Tomcat服务器，则文件会上传到\\%TOMCAT_HOME%\\webapps\\YourWebProject\\WEB-INF\\upload\\文件夹中  
         //   String realPath uest.getSession().getServletContext().getRealPath("/WEB-INF/upload");  = req
            //这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉，我是看它的源码才知道的  
          //  FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, myfile.getOriginalFilename()));  
        	// 获得Excel文件第一个Sheet
            InputStream in = myfile.getInputStream();
            POIFSFileSystem poifsFileSystem = new POIFSFileSystem(in);
    		HSSFWorkbook wb = new HSSFWorkbook(poifsFileSystem);

    		// 防止空指针异常
    		wb.setMissingCellPolicy(Row.CREATE_NULL_AS_BLANK);
    		HSSFSheet sheet = wb.getSheetAt(0); // 获得excel 第一个sheet

		    		for (Row row : sheet) {
		    			// 变量工作sheet 每行数据
		    			if (row.getRowNum() == 0) {
		    				// 第一行 跳过
		    				continue;
		    			}

    				Customer customer = new Customer();
    				//customer.setId(row.getCell(0).getStringCellValue());
    				customer.setName(row.getCell(0)
    						.getStringCellValue());
    				customer.setGender(row.getCell(1).getStringCellValue());
    				customer.setAddress( row.getCell(2)
    						.getStringCellValue());
    				customer.setTelephone(row.getCell(3).getStringCellValue());


    				// 直接将 customer 代码传递Service
    				customerDao.add(customer);
    			}
        }  
		
	
		return "success";
	}
	
	@RequestMapping(value ="/download/{fileName}")
	public void exportData(@PathVariable("fileName")  String fileName , HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		String realPath = request.getSession().getServletContext().getRealPath("/WEB-INF/muban");
		 response.setContentType("text/html;charset=utf-8");   
	        request.setCharacterEncoding("UTF-8");  
		 response.setContentType("application/vnd.ms-excel");   
		  response.setHeader("Content-disposition", "attachment; filename="  
                  + new String(fileName.getBytes("utf-8"), "ISO8859-1")); 
		//  response.setHeader("Content-Length", String.valueOf(fileLength));   
		FileInputStream fis;
		try {
			fis = new FileInputStream(realPath+"\\"+fileName);
			OutputStream out = response.getOutputStream();
			byte[] buf = new byte[1024];
			while(fis.read(buf) > 0){
				out.write(buf);
			}
			out.flush();
			out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
	}


}

