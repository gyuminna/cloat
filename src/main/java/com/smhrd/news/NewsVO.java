package com.smhrd.news;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NewsVO {

    private int news_idx;            // 공지 식별자
    private String news_title;        // 제목
    private String news_content;      // 내용 (CLOB)
    private String news_file;         // 첨부 파일명
    private int news_views;          // 조회수
    private Timestamp created_at;     // 생성일
    private Timestamp updated_at;     // 수정일
    private String admin_id;          // 작성자 아이디 (FK)
}