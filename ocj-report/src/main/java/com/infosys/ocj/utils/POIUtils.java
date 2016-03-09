package com.infosys.ocj.utils;



import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;

public class POIUtils {
	/**
	 * 获得excel文件第一个sheet
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public static HSSFSheet getHSSFWorkbookFirstSheet(File file)
			throws Exception {
		InputStream in = new FileInputStream(file);
		POIFSFileSystem poifsFileSystem = new POIFSFileSystem(in);
		HSSFWorkbook wb = new HSSFWorkbook(poifsFileSystem);

		// 防止空指针异常
		wb.setMissingCellPolicy(Row.CREATE_NULL_AS_BLANK);
		HSSFSheet sheet = wb.getSheetAt(0); // 获得excel 第一个sheet

		return sheet;
	}

}
