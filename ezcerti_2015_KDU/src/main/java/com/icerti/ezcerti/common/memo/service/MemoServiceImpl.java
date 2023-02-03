package com.icerti.ezcerti.common.memo.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.common.memo.dao.MemoMapper;
import com.icerti.ezcerti.domain.Memo;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;

@Transactional
@Service
public class MemoServiceImpl implements MemoService {
	
	@Autowired
	private MemoMapper memoMapper = null;

	@Override
	public PageBean<Memo> getMemoList(Map<String, Object> map) {
		PageBean<Memo> pageBean = new PageBean<Memo>();

		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = memoMapper.getMemoListCount(map);
				
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(memoMapper.getMemoList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	@Override
	public Map<String, Object> getMemoView(Map<String, Object> map) {
		
		updateMemoInfo(map);

		Memo memo= memoMapper.getMemoView(map);
		
		map.put("memo", memo);
		
		return map;
	}	

	@Override
	public void updateMemoInfo(Map<String, Object> map) {
		memoMapper.updateMemoInfo(map);
	}

	@Override
	public void deleteMemoInfo(Memo memo) {
		memoMapper.deleteMemoInfo(memo);
	}

	@Override
	public void insertMemoInfo(Memo memo) {

		String strToUserNo = memo.getTo_user_no();
		String strToUserName = memo.getTo_user_name();

		String[] arrToUserNo = null; 
		String[] arrToUserName = null; 
				
		if(strToUserNo != null) {
			System.out.println("strToUserNo != null");
			
			arrToUserNo = strToUserNo.split(",");
			arrToUserName = strToUserName.split(",");
		} else {
			System.out.println("strToUserNo == null");			
		}
		
		if(arrToUserNo != null && arrToUserNo.length > 0) {
			for(int i = 0; i < arrToUserNo.length; i++) {
				memo.setTo_user_no(arrToUserNo[i]);
				memo.setTo_user_name(arrToUserName[i]);
				
				memoMapper.insertMemoInfo(memo);
			}			
		}		
	}
	
}