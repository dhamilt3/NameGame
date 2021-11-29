Rails.application.routes.draw do



  # Routes for the Draw resource:

  # CREATE
  post("/insert_draw", { :controller => "draws", :action => "create" })
          
  # READ
  get("/draws", { :controller => "draws", :action => "index" })
  
  get("/draws/:path_id", { :controller => "draws", :action => "show" })
  
  # UPDATE
  
  post("/modify_draw/:path_id", { :controller => "draws", :action => "update" })
  
  # DELETE
  get("/delete_draw/:path_id", { :controller => "draws", :action => "destroy" })

  #------------------------------

  # Routes for the Play resource:

  # CREATE
  post("/insert_play", { :controller => "plays", :action => "create" })
          
  # READ
  get("/plays", { :controller => "plays", :action => "index" })
  
  get("/plays/:path_id", { :controller => "plays", :action => "show" })
  
  # UPDATE
  
  post("/modify_play/:path_id", { :controller => "plays", :action => "update" })
  
  # DELETE
  get("/delete_play/:path_id", { :controller => "plays", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  # Routes for the Roster resource:

  # CREATE
  post("/insert_roster", { :controller => "rosters", :action => "create" })
          
  # READ
  get("/rosters", { :controller => "rosters", :action => "index" })
  
  get("/rosters/:path_id", { :controller => "rosters", :action => "show" })
  
  # UPDATE
  
  post("/modify_roster/:path_id", { :controller => "rosters", :action => "update" })
  
  # DELETE
  get("/delete_roster/:path_id", { :controller => "rosters", :action => "destroy" })

  #------------------------------

end
