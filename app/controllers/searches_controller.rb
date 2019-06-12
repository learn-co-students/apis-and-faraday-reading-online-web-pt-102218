class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'MLI4M5MNNEJOGXSXBV3D43NPG24EO2IHVLZEKUWCJX1ZC024'
      req.params['client_secret'] = 'UUVR5ZS1ON1KQXM5FVMTY501FJF4IOXIPFXS1O5N3SP5K1LE'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 0
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