class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if !@@cart.empty?
        @@cart.each {|cart_item| resp.write "#{cart_item}\n" }
      else
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write add_items(search_term)
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
       "#{search_term} is one of our items"
    else
       "Couldn't find #{search_term}"
    end
  end

  def add_items(search_term)
    if @@items.include?(search_term)
        @@cart << search_term
        "added #{search_term}"
    else
        "We don't have that item"
    end
  end
end

# http://localhost:9292/cart
# http://localhost:9292/add?item=Pears