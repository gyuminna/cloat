package com.smhrd.qna;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaService {

    @Autowired
    private QnaMapper mapper;

    // 조회수 증가
    public void increaseViews(int qnaNo) {
        mapper.updateQnaViews(qnaNo);
    }

    // 상세 게시글 조회 (reNum -> int 형 변환 후 조회)
    public QnaVO getQnaDetail(String reNum) {
        int qnaIdx = Integer.parseInt(reNum);
        return mapper.getQna(qnaIdx);
    }
}