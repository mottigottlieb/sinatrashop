require 'sinatra/base'

module Sinatra  
  module Tax
    module Helpers
    end
  
    def self.registered(app)
      app.helpers Tax::Helpers

      app.post '/tax_rate' do
        input = json_to_hash(request.body.read.to_s)
	cart = Cart.new(request.cookies["cart"])
        #replace with calculators, later
        tax_rate = State.find(input[:ship_state]).tax_rate
        (tax_rate.rate.to_f*cart.total).to_json
      end
    end
  end
end
