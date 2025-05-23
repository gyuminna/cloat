package com.smhrd.qna;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QnaVO {

	private int qna_idx;
	private String qna_title;
	private String qna_content;
	private String qna_file;
	private int qna_views;
	private String id;
	private Date created_at;
}