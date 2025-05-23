package com.smhrd.map;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MapController {

	@Autowired 
	MapMapper mapper;
	
	@RequestMapping("/map")
	public String map(@RequestParam String type) {
		
		System.out.println(type + "map");
		String encodedType = "";
		try {
			encodedType = URLEncoder.encode(type, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "redirect:/searchMap?searchValue=0&type=" + encodedType + "&searchKeyword=";
	}
	
	@RequestMapping("/searchMap")
	public String searchMap(@RequestParam String searchValue,  @RequestParam String searchKeyword, 
							@RequestParam String type, Model model){
		
		
		System.out.println(type + "searchMap");
		List<MapVO> mapvo = null;
		
		if(searchValue=="1") {
			mapvo = mapper.searchMap1(searchKeyword, type);
		}else if(searchValue=="2") {
			mapvo = mapper.searchMap2(searchKeyword, type);
		}else if(searchValue=="3") {
			mapvo = mapper.searchMap3(searchKeyword, type);
		}else {
			mapvo = mapper.searchMap(searchKeyword, type);
		}
		model.addAttribute("type", type);
		model.addAttribute("mapvo", mapvo);
		return "map/Map";
	}
	
	
}