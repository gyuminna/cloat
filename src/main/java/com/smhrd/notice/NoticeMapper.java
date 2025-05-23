package com.smhrd.notice;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface NoticeMapper {

    List<NoticeVO> NoticeList();

    NoticeVO getNotice(int notice_idx);

    int getTotalCount();

    List<NoticeVO> getNoticesByPage(@Param("startRow") int startRow, @Param("endRow") int endRow);

    void updateNoticeViews(@Param("noticeIdx") int noticeIdx);
    
    
    
    

	public int write(NoticeVO vo);

	public List<NoticeVO> NoticeSearch(String searchValue, String searchContent);
}