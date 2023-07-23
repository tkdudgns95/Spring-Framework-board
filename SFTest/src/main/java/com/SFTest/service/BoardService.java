package com.SFTest.service;

import java.util.List;
import java.util.Map;

import com.SFTest.dto.BoardVO;
import com.SFTest.dto.FileVO;
import com.SFTest.dto.replyVO;
import com.SFTest.dto.LikeVO;

public interface BoardService {

	// 게시물 목록 보기
	public List<BoardVO> list(int startPoint, int postNum, String keyword);

	// 게시물 등록
	public void write(BoardVO board);

	// 파일 업로드 정보 등록
	public void fileInfoRegistry(Map<String, Object> fileInfo) throws Exception;

	// 게시글 내에서 업로드된 파일 목록 보기
	public List<FileVO> fileListView(int seqno) throws Exception;

	// 게시물 수정에서 파일 삭제
	public void deleteFileList(Map<String, Object> data) throws Exception;

	// 게시물 삭제에서 파일 삭제를 위한 파일 목록 가져 오기
	public List<FileVO> deleteFileOnBoard(int seqno) throws Exception;

	// 회원 탈퇴 시 회원이 업로드한 파일 정보 가져 오기
	public List<FileVO> fileInfoByUserid(String userid) throws Exception;

	// 다운로드를 위한 파일 정보 보기
	public FileVO fileInfo(int fileseqno) throws Exception;

	// 게시물 상세보기
	public BoardVO view(int seqno);

	// 조회수 업데이트
	public void hitno(BoardVO board);

	// 게시물 수정
	public void modify(BoardVO board);

	// 게시물 삭제
	public void delete(int seqno);

	// 게시물 이전 보기
	public int pre_seqno(int seqno, String keyword);

	// 게시물 다음 보기
	public int next_seqno(int seqno, String keyword);

	public int getTotalCount(String keyword);

	// 좋아요/싫어요 확인 가져 오기
	public LikeVO likeCheckView(int seqno, String userid) throws Exception;

	// 좋아요/싫어요 갯수 수정하기
	public void boardLikeUpdate(int seqno, int likecnt, int dislikecnt) throws Exception;

	// 좋아요/싫어요 확인 등록하기
	public void likeCheckRegistry(Map<String, Object> map) throws Exception;

	// 좋아요/싫어요 확인 수정하기
	public void likeCheckUpdate(Map<String, Object> map) throws Exception;

	// 댓글 보기
	public List<replyVO> replyView(replyVO reply) throws Exception;

	// 댓글 수정
	public void replyUpdate(replyVO reply) throws Exception;

	// 댓글 등록
	public void replyRegistry(replyVO reply) throws Exception;

	// 댓글 삭제
	public void replyDelete(replyVO reply) throws Exception;

}
