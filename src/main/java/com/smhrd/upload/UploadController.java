package com.smhrd.upload;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class UploadController {

	//업로드용
	@Autowired
	ServletContext context;
	
	@RequestMapping("/upload")
	public String upload(@RequestParam(value= "file", required = false)MultipartFile file) {
		String loc = context.getRealPath("/resources/upload/");
	    System.out.println("저장 경로: " + loc);
		FileOutputStream fos;
		String fileDemo = file.getOriginalFilename();
		System.out.println(loc);
		if(fileDemo.length() > 0) {
			try {
				File targetFile = new File(loc, fileDemo);
				fos = new FileOutputStream(targetFile);
				fos.write(file.getBytes());
				fos.close();
				System.out.println("파일 저장 경로: " + targetFile.getAbsolutePath());     
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return fileDemo;
		
	}
	
}