package com.SFTest.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.SFTest.dao.MasterDAO;
import com.SFTest.dto.FileVO;

@Service
public class MasterServiceImpl implements MasterService {

	@Autowired
	MasterDAO dao;

	@Override
	public int filedeleteCount() {
		return dao.filedeleteCount();
	}

	@Override
	public List<FileVO> filedeleteList() {
		return dao.filedeleteList();
	}

	@Override
	public void deleteFile(int fileseqno) {
		dao.deleteFile(fileseqno);
	}

}
