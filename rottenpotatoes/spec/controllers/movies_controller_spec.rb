require 'rails_helper'

RSpec.describe MoviesController do
  describe 'In the index page' do
    it 'Index route' do
      get :index
    end
  end
  
  describe 'In the add movie page' do 
    movie=FactoryBot.create(:movie) 
    it 'can direct to the add route' do
      #expect(get: '/movies/new').to route_to(controller: 'movies', action: 'new')
      get 'new'
      response.should render_template(:new)
    end
    it 'create new movie' do 
      before_count = Movie.count
      post :create, {:movie => movie.attributes}
      expect(Movie.count).not_to eq(before_count)
      # expect()
    end
  end
  
  describe 'In the delete movie page' do 
    movie=FactoryBot.create(:movie,:with_director) 
    it 'can delete successfully' do
    #expect(get: '/movies/new').to route_to(controller: 'movies', action: 'new')
    delete 'destroy',{:id => movie.id}
    expect(Movie.find_by_id(movie.id)).to eql(nil)
    end
    
    it 'can direct to home page ' do
    #expect(get: '/movies/new').to route_to(controller: 'movies', action: 'new')
    delete 'destroy',{:id => movie.id}
    expect(response).to redirect_to('/movies')
    end
  end
  
  describe 'In the edit movie page' do 
    movie=FactoryBot.create(:movie,:with_director) 
    it 'can direct to the edit route' do
      get 'edit' ,  {:id => movie.id}
      response.should render_template(:edit)
    #expect(get: '/movies/1/edit').to route_to(controller: 'movies', action: 'edit',id: '1')
    end
    
    it 'can update correctly' do
      id = movie.id
      before_title=movie.title
      movie.update_attributes(:director => 'yyy',:title => 'title_xxx')
      put :update, :id => id, :movie => movie.attributes
      expect(movie.director).to eql('yyy')
      expect(movie.title).not_to eql(before_title)
    end
    
  end
  
  describe 'In the more detail page' do 
    movie=FactoryBot.create(:movie) 
    it 'detail route' do
      get 'show' ,  {:id => movie.id}
      response.should render_template(:show)
    end
  end
  
  describe 'Find movies with same directors ' do 
    movie1=FactoryBot.create(:movie,:with_director) 
    movie2=FactoryBot.create(:movie) 
    movie3=FactoryBot.create(:movie,:with_director) 
    movie4=FactoryBot.create(:movie) 
    it 'it can direct to similar movie route' do
      get 'search' ,  {:id => movie1.id}
      response.should render_template(:search)
    end
    it 'redirect to home page if movie does not have director' do
      get 'search' ,  {:id => movie2.id}
      expect(response).to redirect_to('/movies')
    end 
    
     it 'redirect to similar movie page if movie have director' do
      get 'search' ,  {:id => movie1.id}
      expect(response).not_to redirect_to('/movies')
  end
    it 'return similar movies if two movies have same directors' do
      get 'search' ,  {'id' => movie1.id}
      m=[movie1, movie3]
  end
end
  
end
