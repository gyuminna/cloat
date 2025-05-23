package com.smhrd.map;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MapVO {

 // 위치 식별자 
 private Double map_idx;

 // 시도 
 private String sido;

 // 시군구 
 private String sigungu;

 // 주소 
 private String addr;

 // 기관 명 
 private String org_name;

 // 기관 타입 
 private String org_type;

 // 기관 연락처 
 private String org_tel;

 // 위도 
 private Double lat;

 // 경도 
 private Double lon;

 // 등록 일자 
 private Timestamp created_at;

 // 관리자 아이디 
 private String admin_id;
 }