package com.smhrd.member;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.qna.QnaVO;

@Controller
public class MemberController {

    @Autowired
    MemberMapper mapper;
    
    @Autowired
    ServletContext context;

    @RequestMapping("/")
    public String main() {
        return "Main"; // 메인 페이지 뷰 이름
    }

    @RequestMapping("/login")
    public String login() {
        return "member/Login"; // 로그인 페이지 뷰 이름
    }

    @PostMapping("/login_do")
    public String login(MemberVO vo, HttpSession session) {
        MemberVO mvo = mapper.login(vo);

        if (mvo != null) {
            // 로그인 성공 - 세션에 사용자 정보 저장
            session.setAttribute("mvo", mvo);
            return "redirect:/"; // 마이페이지로 이동
        } else {
            // 로그인 실패 - 로그인 페이지로 되돌아가기
            return "redirect:/login";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "Main"; // 로그아웃 후 메인페이지로
    }

    @RequestMapping("/join")
    public String join() {
        return "member/Join"; // 회원가입 페이지 뷰
    }

    @ResponseBody
    @RequestMapping("/IdCheck")
    public Map<String, Boolean> IdCheck(@RequestParam String id) {
        System.out.println(id);
        int cnt = mapper.IdCheck(id);
        boolean available = cnt == 0;
        Map<String, Boolean> response = new HashMap<>();
        response.put("available", available);
        return response;
    }

    @RequestMapping("/join_us")
    public String join_us(@RequestParam(value= "file", required = false) MultipartFile file, MemberVO vo, Model model) {
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

        vo.setProfile_img(fileDemo);
        mapper.join(vo);
        model.addAttribute("id", vo.getId());
        return "member/Join_success";
    }

    @GetMapping("/join_success")
    public String join_success() {
        return "member/Join_success";
    }

    // ** 마이페이지 컨트롤러 추가 **
    @RequestMapping("/mypage")
    public String My_edit(HttpSession session, Model model) {
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        if (mvo == null) {
            return "redirect:/login"; // 로그인 안 되어 있으면 로그인 페이지로 이동
        }
        model.addAttribute("member", mvo);
        return "mypage/MyGallery"; // 마이페이지 뷰 이름
    }
    
    @GetMapping("/MyLogin")
    public String MyLogin() {
        return "mypage/MyLogin";
    }    
    
	@PostMapping("/login_to")
	public String login_to(MemberVO vo) {
		MemberVO mvo = mapper.login(vo);
				
		if (mvo != null) {
			return "mypage/MyEdit"; // 내 정보수정 페이지로 이동
		} else {
			// 로그인 실패 - 로그인 페이지로 되돌아가기
			return "mypage/MyLogin";
		}
	}    
    
    @GetMapping("/MyEdit")
    public String MyEdit() {																																																																																		
        return "mypage/MyEdit";
    }
   
	@PostMapping("/Update")
	public String update(@RequestParam(value= "file", required = false)MultipartFile file, MemberVO vo, Model model, 
			RedirectAttributes redirectAttr, HttpSession session) {
		System.out.println(vo);
		String loc = context.getRealPath("/resources/file/");
		FileOutputStream fos;
		String fileDemo = null;
		if (file != null && !file.isEmpty()) {
			fileDemo = file.getOriginalFilename();
			if(fileDemo.length() > 0) {
				try {
					String baseName = fileDemo.substring(0, fileDemo.lastIndexOf(".")); //4
					String extension = fileDemo.substring(fileDemo.lastIndexOf("."));   //.jpg
					fileDemo = baseName + '_' + UUID.randomUUID().toString() + extension;
					File targetFile = new File(loc, fileDemo);
					fos = new FileOutputStream(targetFile); // 파일저장경로 + 파일저장명
					fos.write(file.getBytes());  // 우리가 진짜 가져온 파일로 쓰기
					fos.close();  // 이건 안써줘도 되는 코드지만 용량 절약을 습관화
				} catch (Exception e) {
		            e.printStackTrace();
		            redirectAttr.addFlashAttribute("msg", "파일 업로드 중 오류가 발생했습니다.");
		            return "mypage/MyEdit";					
				}
			}
		}
		vo.setProfile_img(fileDemo);

		int result = mapper.update(vo);
		session.setAttribute("mvo", vo);	
	    if (result > 0) {
	        redirectAttr.addFlashAttribute("msg", "정보수정이 완료되었습니다.");
	    } else {
	        redirectAttr.addFlashAttribute("msg", "정보수정에 실패했습니다. 다시 시도해주세요.");	        
	    }
	    return "redirect:/MyEdit";
		
	}
	
    @GetMapping("/MyGallery")
    public String MyGallery() {
        return "mypage/MyGallery";
    }
    
//    @GetMapping("/MyQna")
//    public String MyQna() {
//        return "mypage/MyQna";
//    }
    
 
    
//    @GetMapping("/MyReview")
//    public String MyReview() {
//        return "mypage/MyReview";
//    }    
    
}