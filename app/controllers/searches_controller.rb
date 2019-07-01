class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['client_id'] = TJK2QRGIUVX0ZHAG1YYBI3QXURGE5YEHOZRK5RQADMVOVV3A
    req.params['client_secret'] = FVUZW0MWLXESNZ2YK2CPN2SH53X4YZF43UWJYJWSRO2ZYTIS
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
  render 'search'
  end
end