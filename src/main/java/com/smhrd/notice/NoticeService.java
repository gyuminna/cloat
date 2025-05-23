package com.smhrd.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {

    @Autowired
    private NoticeMapper mapper;

    // 조회수 증가
    public void increaseViews(int noticeNo) {
        mapper.updateNoticeViews(noticeNo);
    }

    // 상세 게시글 조회 (reNum -> int 형 변환 후 조회)
    public NoticeVO getNoticeDetail(String reNum) {
        int noticeIdx = Integer.parseInt(reNum);
        return mapper.getNotice(noticeIdx);
    }
}