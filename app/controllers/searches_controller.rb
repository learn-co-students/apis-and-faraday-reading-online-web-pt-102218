class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = W5SVVGL1ZWZVICQPOCZMEBWDDDHLQY3PLJL2HGYHDKAF3WLM
      req.params['client_secret'] = 3Q24UHCG1SG22PEW54YGTISC3TNM2NNR5SRDXPPZJM04ZMX5
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end
