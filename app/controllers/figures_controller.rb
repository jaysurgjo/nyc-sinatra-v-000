class FiguresController < ApplicationController
  use Rack::MethodOverride

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures/:id' do

    @figure = Figure.create(params[:figure])

    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @new_landmark
    end

    if !params[:title][:name].empty?
      @new_title = Title.create(params[:title])
      @figure.titles << @new_title
    end

    @figure.save
    redirect to "figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      @figure.landmarks << @new_landmark
    end

    if !params[:title][:name].empty?
      @new_title = Title.find_or_create_by(name: params[:title][:name])
      @figure.titles << @new_title
    end

    @figure.save
    redirect to "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do

    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all

    erb :'/figures/edit'
  end
end
