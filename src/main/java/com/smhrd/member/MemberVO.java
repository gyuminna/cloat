package com.smhrd.member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

	private String id;
	private String pw;
	private String name;
	private String email;
	private String phone;
	private String profile_img;
	private String user_type;
	
}