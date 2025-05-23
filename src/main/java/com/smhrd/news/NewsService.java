package com.smhrd.news;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NewsService {

    @Autowired
    private NewsMapper mapper;

    // 조회수 증가
    public void increaseViews(int noticeNo) {
        mapper.updateNewsViews(noticeNo);
    }

    // 상세 게시글 조회 (reNum -> int 형 변환 후 조회)
    public NewsVO getNewsDetail(String reNum) {
        int noticeIdx = Integer.parseInt(reNum);
        return mapper.getNews(noticeIdx);
    }

}