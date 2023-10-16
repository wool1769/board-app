package com.board.mvc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.mvc.domain.Favorites;
import com.board.mvc.repository.FavoritesRepository;

@Service
public class FavoritesService {
	@Autowired
	private FavoritesRepository repository;
	
	public boolean save(Favorites favorites) {
		boolean check = repository.check(favorites)==0;
		
		if(check) {
			repository.save(favorites);
		}
		
		return check;
	}
	
	public boolean delete(Favorites favorites) {
		boolean check = repository.check(favorites)!=0;
		
		if(check) {
			repository.delete(favorites);
		}
		
		return check;
	}
	
	public boolean get(Favorites favorites) {
		boolean check = repository.check(favorites)!=0;
		
		return check;
	}

}
