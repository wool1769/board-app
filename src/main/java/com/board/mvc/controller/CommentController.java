package com.board.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.board.mvc.domain.Comment;
import com.board.mvc.service.CommentService;
import com.board.passwordHashing.PasswordHashing;

@RestController
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	private CommentService service;
	
	@Autowired
	private PasswordHashing passwordHashing;
	
	@PostMapping("/save")
	public void save(@RequestBody Comment comment) {
		System.out.println("?????????????????");
		System.out.println(comment);
		service.save(comment);
	}
	
	//삭제할거 전체조회 게시판아이디 전달해야함
	@GetMapping("/listget")
	public List<Comment> getList(@RequestParam int boardId){
		return service.getList(boardId);
	}
	
	@DeleteMapping("/delete")
	public boolean delete(@RequestParam String memberPw,int commentId) {
		memberPw = passwordHashing.hashPassword(memberPw);
		
		return service.delete(memberPw,commentId);
	}
	
	//삭세할거임
	@DeleteMapping("/boardall")
	public void deleteBoardAll(@RequestParam int boardId) {
		service.deleteBoardAll(boardId);
	}
	//삭제할거
	@DeleteMapping("/userall")
	public void deleteUserAll(@RequestParam String id) {
		service.deleteUserAll(id);
	}
}
