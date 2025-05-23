package com.smhrd.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {

    @Autowired
    private ReviewMapper mapper;

    // 조회수 증가
    public void increaseViews(int reviewNo) {
        mapper.updateReviewViews(reviewNo);
    }

    // 상세 게시글 조회 (reNum -> int 형 변환 후 조회)
    public ReviewVO getReviewDetail(String reNum) {
        int reviewIdx = Integer.parseInt(reNum);
        return mapper.getReview(reviewIdx);
    }
}