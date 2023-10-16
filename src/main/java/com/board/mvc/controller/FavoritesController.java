package com.board.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.board.mvc.domain.Favorites;
import com.board.mvc.service.FavoritesService;

@RestController
@RequestMapping("/favorites")
public class FavoritesController {
	@Autowired
	private FavoritesService service;
	
	@PostMapping("/save")
	public boolean save(@RequestBody Favorites favorites) {
		System.out.println(favorites.getId());
		System.out.println(favorites.getBoardId());
//		return true;
		return service.save(favorites);

	}
	
	@PostMapping("/delete")
	public boolean delete(@RequestBody Favorites favorites) {
		return service.delete(favorites);
	}
	
	@PostMapping("/get")
	public boolean get(@RequestBody Favorites favorites) {
		return service.get(favorites);
	}
}
