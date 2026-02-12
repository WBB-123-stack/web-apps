Rails.application.routes.draw do
  resources :companies
  # get("/things", :controller => "things", :action => "index")
  get("/tacos", :controller => "tacos", :action => "index")
  get("/dice", :controller => "dice", :action => "index")
  get("/craps", :controller => "craps", :action => "index")
    get("/companies", :controller => "companies", :action => "index")


  
end
