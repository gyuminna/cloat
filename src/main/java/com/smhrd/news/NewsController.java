package com.smhrd.news;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.smhrd.news.NewsService;
import com.smhrd.news.NewsVO;

@Controller 
public class NewsController {
	
	@Autowired
	NewsMapper mapper;
	
    @Autowired
    private NewsService newsService;
    
    @Autowired
    ServletContext context;

    // 뉴스 상세보기 + 조회수 증가
    @RequestMapping("/newsview")
    public String newsView(@RequestParam("no") int newsIdx,
                             @RequestParam(value="pageNum", defaultValue="1") int pageNum,
                             Model model) {
        newsService.increaseViews(newsIdx);
        NewsVO news = mapper.getNews(newsIdx);
        model.addAttribute("news", news);
        model.addAttribute("pageNum", pageNum);  // 페이지 번호 같이 넘김
        return "news/NewsView";
    }

    // 공지사항 목록 + 페이징 처리
    @RequestMapping("/NewsList")
    public String newsList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
        int pageSize = 10;
        int startRow = (pageNum - 1) * pageSize + 1;
        int endRow = pageNum * pageSize;

        int totalCount = mapper.getTotalCount();
        int totalPageCount = (totalCount + pageSize - 1) / pageSize;

        List<NewsVO> list = mapper.getNewssByPage(startRow, endRow);
        if (list == null) list = new ArrayList<>();

        int pageBlock = 10;
        int startPageNum = ((pageNum - 1) / pageBlock) * pageBlock + 1;
        int endPageNum = Math.min(startPageNum + pageBlock - 1, totalPageCount);

        model.addAttribute("list", list);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("startPageNum", startPageNum);
        model.addAttribute("endPageNum", endPageNum);

        return "news/News";
    }

    // 게시글 상세보기 (예: 리뷰 형식, 쿼리 파라미터로 reNum 받음)
    @RequestMapping("/newsdetailreview")
    public ModelAndView detail(@RequestParam("reNum") String reNum) throws Exception {
        return new ModelAndView("detail", "detail1", newsService.getNewsDetail(reNum));
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

	@RequestMapping("/NewsSearch")
	public String NewsSearch(@RequestParam String searchValue, @RequestParam String searchContent ,Model model) {
		
		List<NewsVO> list = mapper.NewsSearch(searchValue, searchContent);
		System.out.println(searchValue + " " + searchContent);
		model.addAttribute("list", list);
		return "news/News";
	}

	@RequestMapping("/NewsWrite")
	public String NewsWrite(Model model) {
		return "news/NewsWrite";
	}
	
	@RequestMapping("/NewsUpload")
	public String NewsUpload(NewsVO vo, @RequestParam(value= "file", required = false)MultipartFile file) {
		String loc = context.getRealPath("/resources/file/");
		FileOutputStream fos;
		String fileDemo = "null";
		if (file != null && !file.isEmpty()) {
			fileDemo = file.getOriginalFilename();
			if(fileDemo.length() > 0) {
				try {
					String baseName = fileDemo.substring(0, fileDemo.lastIndexOf("."));
					String extension = fileDemo.substring(fileDemo.lastIndexOf("."));
					fileDemo = baseName + '_' + UUID.randomUUID().toString() + extension;
					File targetFile = new File(loc, fileDemo);
					fos = new FileOutputStream(targetFile);
					fos.write(file.getBytes());
					fos.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		vo.setNews_file(fileDemo);
		vo.setNews_views(0);
		
		int result = mapper.write(vo);
		
		if(result>0) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		return "redirect:/NewsList";
	}
	
}