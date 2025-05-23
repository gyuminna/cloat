package com.smhrd.notice;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {

    private int notice_idx;
    private String notice_title;
    private String notice_content;
    private String notice_file;
    private int notice_views;
    private String admin_id;
    private String id;
    private Date created_at;
}