class PlaysController < ApplicationController
  def index
    matching_plays = Play.all
    @list_of_plays = matching_plays.order({ :created_at => :desc })
    render({ :template => "plays/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_plays = Play.where({ :id => the_id })
    @the_play = matching_plays.at(0)
    render({ :template => "plays/show.html.erb" })
  end

  def new_play
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
    render({:template => "plays/new_play.html.erb"})
  end

  def start
    render({:template => "plays/start.html.erb"})
  end


  def view_play_result
    user_plays = Play.all.where({:user_id => @current_user.id })    #find the active record relation for all plays the user has made
    completed_plays = user_plays.count                              #count the number of user_plays   
    play_id = session.fetch("play_id")     #retireve the current play id from the cookie
    the_play = Play.all.where({:id => play_id}).at(0) #retrieve the play record from the current play
    the_play.user_play = completed_plays    #set the user_play field equal to the completed plays
    the_play.save                           #save the play record
    @user_play = the_play.user_play         #create an instance variable of the user play

    user_id = @current_user.id
    the_user = User.all.where({:id => user_id}).first
    the_user.plays_count = completed_plays
    the_user.save

    @play_last_id = session.fetch("play_id")
    @draw_set = Draw.all.where({:play_id => @play_last_id})

    session.store(:play_id, nil)
    session.store(:draw_number, nil)

    render({:template => "plays/view_play_result.html.erb"})
  end









  def create
    the_play = Play.new
    the_play.user_id = @current_user.id

    # if the_play.valid?
      the_play.save
      @current_play = the_play.id
      redirect_to("/new_draw_start", { :notice => "Play created successfully." })
    # else
    #   redirect_to("/play", { :notice => "Play failed to create successfully." })
    # end
  end







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
