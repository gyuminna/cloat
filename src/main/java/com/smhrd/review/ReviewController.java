package com.smhrd.review;

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

import com.smhrd.qna.QnaVO;
import com.smhrd.review.ReviewService;
import com.smhrd.review.ReviewVO;

@Controller 
public class ReviewController {
	
	@Autowired
	ReviewMapper mapper;


    @Autowired
    private ReviewService reviewService;
    
    @Autowired
    ServletContext context;

    // 리뷰 상세보기 + 조회수 증가
    @RequestMapping("/reviewview")
    public String reviewView(@RequestParam("no") int reviewIdx,
                             @RequestParam(value="pageNum", defaultValue="1") int pageNum,
                             Model model) {
    	reviewService.increaseViews(reviewIdx);
        ReviewVO review = mapper.getReview(reviewIdx);
        model.addAttribute("review", review);
        model.addAttribute("pageNum", pageNum);  // 페이지 번호 같이 넘김
        return "review/ReviewView";
    }


    // 리뷰 목록 + 페이징 처리
    @RequestMapping("/ReviewList")
    public String reviewList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
        int pageSize = 10;
        int startRow = (pageNum - 1) * pageSize + 1;
        int endRow = pageNum * pageSize;

        int totalCount = mapper.getTotalCount();
        int totalPageCount = (totalCount + pageSize - 1) / pageSize;

        List<ReviewVO> list = mapper.getReviewsByPage(startRow, endRow);
        if (list == null) list = new ArrayList<>();

        int pageBlock = 10;
        int startPageNum = ((pageNum - 1) / pageBlock) * pageBlock + 1;
        int endPageNum = Math.min(startPageNum + pageBlock - 1, totalPageCount);

        model.addAttribute("list", list);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("startPageNum", startPageNum);
        model.addAttribute("endPageNum", endPageNum);

        return "review/Review";
    }

    // 게시글 상세보기 (예: 리뷰 형식, 쿼리 파라미터로 reNum 받음)
    @RequestMapping("/reviewdetailreview")
    public ModelAndView detail(@RequestParam("reNum") String reNum) throws Exception {
        return new ModelAndView("detail", "detail1", reviewService.getReviewDetail(reNum));
    }
    
    // 마이페이지 - 내가 쓴 리뷰보기
    @RequestMapping("/MyReview")
    public String MyReview(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, 
    					@RequestParam(value ="id") String id,
    					Model model) {
        int pageSize = 10;
        int startRow = (pageNum - 1) * pageSize + 1;
        int endRow = pageNum * pageSize;

        int totalCount = mapper.getTotalCount();
        int totalPageCount = (totalCount + pageSize - 1) / pageSize;
        List<ReviewVO> list = mapper.MyReview(startRow, endRow, id);
        if (list == null) list = new ArrayList<>();
        
        int pageBlock = 10;
        int startPageNum = ((pageNum - 1) / pageBlock) * pageBlock + 1;
        int endPageNum = Math.min(startPageNum + pageBlock - 1, totalPageCount);

        model.addAttribute("list", list);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("startPageNum", startPageNum);
        model.addAttribute("endPageNum", endPageNum);

        return "mypage/MyReview";
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

	@RequestMapping("/ReviewSearch")
	public String ReviewSearch(@RequestParam String searchValue, @RequestParam String searchContent ,Model model) {
		
		List<ReviewVO> list = mapper.ReviewSearch(searchValue, searchContent);
		System.out.println(searchValue + " " + searchContent);
		model.addAttribute("list", list);
		return "review/Review";
	}

	@RequestMapping("/ReviewWrite")
	public String ReviewWrite(Model model) {
		return "review/ReviewWrite";
	}
	
	@RequestMapping("/ReviewUpload")
	public String ReviewUpload(ReviewVO vo, @RequestParam(value= "file", required = false)MultipartFile file) {
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
		
		vo.setReview_file(fileDemo);
		vo.setReview_views(0);
		
		int result = mapper.write(vo);
		
		if(result>0) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		return "redirect:/ReviewList";
	}
	
	
}
    
   