class SearchesController < ApplicationController

  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'N2GAKEX5LG0TDLRUFBCIPNJ1IAA5LPRCMEBRIFHZK3JWU1VV'
      req.params['client_secret'] = '2IVAKGHHINOKCIY1IYRW4N0OSQDRZUKCI1WT4NAZ0UE32ZZZ'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
       @error = body["meta"]["errorDetail"]
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
    render 'search'
  end

end



