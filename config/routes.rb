Rails.application.routes.draw do

  #HOME-----------------------------
  get("/", {:controller => "application", :action => "home" })  #this route has been customized

  # DRAW RESOURCE----------------------------

  # CREATE
  get("/new_draw", {:controller => "draws", :action => "new_draw"})
  
  # READ     
  get("/draw_result", {:controller => "draws", :action => "draw_result"})
  get("/play_history_detail/:play", {:controller => "draws", :action => "play_history"})


  # # UPDATE
  # post("/modify_draw/:path_id", { :controller => "draws", :action => "update" })
  # # DELETE
  # get("/delete_draw/:path_id", { :controller => "draws", :action => "destroy" })

  #not currently in use:
  # post("/insert_draw", { :controller => "draws", :action => "create" })  
  # get("/draws", { :controller => "draws", :action => "index" })
  # get("/draws/:path_id", { :controller => "draws", :action => "show" })


  # PLAY RESOURCE------------------------------------------

  # CREATE
    get("/new_play", {:controller => "plays", :action => "new_play"})
    get("/view_play_result", {:controller => "plays", :action => "view_play_result"})
    get("/user_plays/:user", {:controller => "plays", :action => "user_plays"})
 

    # READ
    # get("/plays", { :controller => "plays", :action => "index" })
    # get("/plays/:path_id", { :controller => "plays", :action => "show" })
    # # UPDATE
    # post("/modify_play/:path_id", { :controller => "plays", :action => "update" })
    # # DELETE
    # get("/delete_play/:path_id", { :controller => "plays", :action => "destroy" })

  # USER RESROUCE:-------------------------------------------------------

    # SIGN UP FORM
    get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })   #customized 
    # CREATE RECORD
    post("/insert_user", { :controller => "user_authentication", :action => "create"  })  #checked and functional  
    # EDIT PROFILE FORM        
    get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
    # UPDATE RECORD
    post("/modify_user", { :controller => "user_authentication", :action => "update" })
    # DELETE RECORD
    get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

 #SIGN IN RESROUCE -----------------------------------------------------------------------------------

  # SIGN IN FORM 
    get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
    # AUTHENTICATE AND STORE COOKIE
    post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
    # SIGN OUT        
    get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
              
  # ROSTER RESOURCE-------------------------------------------------

    # CREATE
    post("/insert_roster", { :controller => "rosters", :action => "create" })     
    # READ
    get("/roster", { :controller => "rosters", :action => "index" })   #validated
    get("/roster/:path_id", { :controller => "rosters", :action => "show" })
    # UPDATE
    post("/modify_roster/:path_id", { :controller => "rosters", :action => "update" }) #validated
    # DELETE
    get("/delete_roster/:path_id", { :controller => "rosters", :action => "destroy" })

  #-----------------------------------------------------------------------------------

end
