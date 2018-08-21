class FiguresController < ApplicationController
  get '/figures' do
    erb :'figures/index'
  end
  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])
    if !params[:title][:name].empty?
      @title = Title.find_or_create_by(name: params[:title][:name])
      @title.save
      @figure.titles << @title
    end
    if !!params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        @title = Title.find(id)
        @title.save
        @figure.titles << @title
      end
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.find_or_create_by(name: params[:landmark][:name], year_completed: params[:landmark][:year])
      @landmark.save
      @figure.landmarks << @landmark
    end
    if !!params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @landmark.save
        @figure.landmarks << @landmark
      end
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
  get '/figures/new' do
    erb :'figures/new'
  end
  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end
  use Rack::MethodOverride
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    if !params[:title][:name].empty?
      @title = Title.find_or_create_by(name: params[:title][:name])
      @title.save
      @figure.titles << @title
    end
    if !!params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        @title = Title.find(id)
        @title.save
        @figure.titles << @title
      end
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.find_or_create_by(name: params[:landmark][:name], year_completed: params[:landmark][:year])
      @landmark.save
      @figure.landmarks << @landmark
    end
    if !!params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @landmark.save
        @figure.landmarks << @landmark
      end
    end
    redirect to "/figures/#{@figure.id}"
  end
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end
end
