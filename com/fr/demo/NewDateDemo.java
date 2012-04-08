package com.fr.demo;

import java.io.File;
import com.fr.base.FRContext;
import com.fr.base.dav.Env;
import com.fr.data.ArrayTableDataDemo;
import com.fr.report.TemplateWorkBook;
import com.fr.report.WorkBook;
import com.fr.report.io.TemplateImporter;
import com.fr.web.Reportlet;
import com.fr.web.ReportletRequest;

public class NewDateDemo extends Reportlet {
	public TemplateWorkBook createReport(ReportletRequest reportletrequest) {
		WorkBook workbook = new WorkBook();
		Env oldEnv = FRContext.getCurrentEnv();
		String envPath = oldEnv.getPath();
		try {
			File cptfile = new File(envPath + "\\reportlets\\bumen.cpt");
			TemplateImporter tplimp = new TemplateImporter();
			workbook = tplimp.generateWorkBook(cptfile);
			ArrayTableDataDemo a = new ArrayTableDataDemo();
			workbook.putTableData("ds1", a);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return workbook;
	}
}