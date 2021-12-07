class PlaysController < ApplicationController


  def new_play
    #reset/build the game cookies
    session.store(:play_id, nil)
    session.store(:play_count, nil)
    session.store(:draw_number, nil)
    session.store(:draw_id, nil)
    session.store(:draw_result, nil)
    session.store(:draw_check, nil)
    session[:sample] = Array.new

    if session.fetch("play_id") == nil                  #if there is not a current play in session
      the_play = Play.new                               #create a new play in the play table
      the_play.user_id = @current_user.id               #set the field "user_id" using the current user cookie
      the_play.save                                     #save the new play record
      @current_play = the_play.id                       #create an ainstance variable of the current play id
      session.store(:play_id, @current_play)            #create a cookie to store the current play
    else 
      the_play = Play.new
      the_play.user_id = @current_user.id
      the_play.save
      @current_play = the_play.id                       #create an ainstance variable of the current play id
      session.store(:play_id, @current_play)  
      the_play_id =  session.fetch("play_id")
      the_play = Play.all.where({:id => the_play_id}).at(0)
    end
  
    user_id = @current_user.id
    user_plays = Play.all.where({:user_id => user_id})
    play_count = user_plays.count
    play_new = play_count
    session.store(:play_count, play_new)


    render({:template => "plays/new_play.html.erb"})
  end


  def view_play_result
    #resolve the last draw
     draw_id = session.fetch("draw_id")
     last_draw = Draw.all.where({:id => draw_id}).first
     @draw_result = session.fetch("draw_result").to_i     #extract the draw_result from the params hash
     last_draw.draw_result = @draw_result
     last_draw.save
    
    #count the plays
    user_plays = Play.all.where({:user_id => @current_user.id })    #find the active record relation for all plays the user has made
    plays_count = user_plays.count                              #count the number of user_plays   

    #count the correct answers
    play_id = session.fetch("play_id")
    user_draws_correct = Draw.all.where({:play_id => play_id}).where({:draw_result => 1})
    @correct_count = user_draws_correct.count.to_f

    #calculate the incorrect answers
    user_draws_correct = Draw.all.where({:play_id => play_id}).where({:draw_result => 0})
    @incorrect_count = user_draws_correct.count.to_f

    #calculate the percent
    @percent = 0
    @percent = @correct_count/(@correct_count + @incorrect_count )
    @percent = @percent*100
    @percent = @percent.to_i
  
  
  #update the play    
    play_id = session.fetch("play_id")                             #retireve the current play id from the cookie
    the_play = Play.all.where({:id => play_id}).at(0) #retrieve the play record from the current play
    the_play.user_play = plays_count    #set the user_play field equal to the completed plays
    the_play.correct_sum = @correct_count
    the_play.incorrect_sum = @incorrect_count
    the_play.percent = @percent
    the_play.save                           #save the play record
    @user_play = the_play.user_play         #create an instance variable of the user play
    

    @draw_set = Draw.all.where({:play_id => play_id})   #returns an array of the plays
    
    user_id = @current_user.id
    the_user = User.all.where({:id => user_id}).first
    the_user.plays_count = plays_count
    the_user.save

    @play_last_id = session.fetch("play_id")
    @draw_set = Draw.all.where({:play_id => @play_last_id})

    render({:template => "plays/view_play_result.html.erb"})
  end


  def user_plays 
    #check to see if the user is logged in
    if @current_user == nil
    redirect_to("/")      
    else # proceed with script    
  
        #this s a feature to prevent a user from seeing another user's plays
      @query_user = params.fetch("user").to_s
      @user = @current_user.id.to_s

      if @query_user == @user #if you are the authorized user, proceed

         @play_set = Play.all.where({:user_id => @user}).order(:user_play => :desc).first(10)

        render({:template => "plays/user_plays.html.erb"})

      else    #else, redirect to the correct page
        redirect_to("/user_plays/"+@user)  
      end
    
    end
  end


  # def index
  #   matching_plays = Play.all
  #   @list_of_plays = matching_plays.order({ :created_at => :desc })
  #   render({ :template => "plays/index.html.erb" })
  # end

  # def show
  #   the_id = params.fetch("path_id")
  #   matching_plays = Play.where({ :id => the_id })
  #   @the_play = matching_plays.at(0)
  #   render({ :template => "plays/show.html.erb" })
  # end


  # def create
  #   the_play = Play.new
  #   the_play.user_id = @current_user.id

  #   # if the_play.valid?
  #     the_play.save
  #     @current_play = the_play.id
  #     redirect_to("/new_draw_start", { :notice => "Play created successfully." })
  #   # else
  #   #   redirect_to("/play", { :notice => "Play failed to create successfully." })
  #   # end
  # end


  # def update
  #   the_id = params.fetch("path_id")
  #   the_play = Play.where({ :id => the_id }).at(0)

  #   the_play.user_id = params.fetch("query_user_id")
  #   the_play.correct_sum = params.fetch("query_correct_sum")
  #   the_play.incorrect_sum = params.fetch("query_incorrect_sum")
  #   the_play.result = params.fetch("query_result")
  #   the_play.draws_count = params.fetch("query_draws_count")

  #   if the_play.valid?
  #     the_play.save
  #     redirect_to("/plays/#{the_play.id}", { :notice => "Play updated successfully."} )
  #   else
  #     redirect_to("/plays/#{the_play.id}", { :alert => "Play failed to update successfully." })
  #   end
  # end

  # def destroy
  #   the_id = params.fetch("path_id")
  #   the_play = Play.where({ :id => the_id }).at(0)
  #   the_play.destroy
  #   redirect_to("/plays", { :notice => "Play deleted successfully."} )
  # end

end
