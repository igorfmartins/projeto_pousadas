class SearchController < ApplicationController
    def results
      term = params[:search_term]
      @results = Inn.search(term) 
    end
end
  