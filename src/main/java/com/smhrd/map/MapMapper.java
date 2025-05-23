package com.smhrd.map;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MapMapper {

	public List<MapVO> map();

	public List<MapVO> searchMap(String searchKeyword, String type);

	public List<MapVO> searchMap1(String searchKeyword, String type);

	public List<MapVO> searchMap2(String searchKeyword, String type);

	public List<MapVO> searchMap3(String searchKeyword, String type);
}