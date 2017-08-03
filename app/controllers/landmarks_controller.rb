class LandmarksController < ApplicationController

  get "/landmarks/new" do
    erb :"landmarks/new"
  end

  post "/landmarks" do
    @landmark = Landmark.create(params[:landmark])
  end

  get "/landmarks" do
    erb :"landmarks/index"
  end

  get "/landmarks/:index" do
    @landmark = Landmark.find(params[:index])
    erb :"landmarks/show"
  end

  get "/landmarks/:index/edit" do
    @landmark = Landmark.find(params[:index])
    erb :"landmarks/edit"
  end

  post "/landmarks/:index/edit" do
    @landmark = Landmark.find(params[:index])
    @landmark.name = params[:landmark][:name] if !params[:landmark][:name].empty?

    @landmark.year_completed = params[:landmark][:year_completed] if !params[:landmark][:year_completed].empty?

    @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end
end
