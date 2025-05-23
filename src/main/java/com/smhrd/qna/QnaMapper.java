package com.smhrd.qna;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface QnaMapper {

	public List<QnaVO> QnaList();

    QnaVO getQna(int qna_idx);

    int getTotalCount();

    List<QnaVO> getQnasByPage(@Param("startRow") int startRow, @Param("endRow") int endRow);

    void updateQnaViews(@Param("qnaIdx") int qnaIdx);
    
    public List<QnaVO> MyQna(@Param("startRow") int startRow, @Param("endRow") int endRow, @Param("id") String id);


	public int write(QnaVO vo);

	public List<QnaVO> QnaSearch(String searchValue, String searchContent);
}