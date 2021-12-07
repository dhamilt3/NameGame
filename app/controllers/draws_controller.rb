class DrawsController < ApplicationController
  
  def new_draw

    #this was code to prevent reh refresh problem
    # draw_number = session.fetch("draw_number")
    # draw_check = session.fetch("draw_check")
    # if draw_number == nil
    #   session.store(:draw_number, 0)
    # end
    # if draw_check == nil
    #   session.store(:draw_check, 0)
    # end
    # draw_number.to_i
    # draw_check.to_i
    # draw_diff = 0
    # draw_diff.to_i
    # draw_diff = draw_number - draw_check
    #proceed 

    #create a new roster sample---------------------------
    roster = Roster.all.where.not(:id => session.fetch(:sample))
    roster_sample = roster.sample  #sample the database
    session[:sample].push(roster_sample.id)

    @photo = roster_sample.image        #extract a photo from the sample
    @roster_id = roster_sample.id         #extract the roster_id from the sample
    @roster_record = Roster.all.where({:id => @roster_id}).at(0)

  #if this is a brand_new draw
  if session.fetch("draw_result") == nil
  #there is no record to update, do nothing
  else           
  #update the previous draw number
    draw_id = session.fetch("draw_id")
    last_draw = Draw.all.where({:id => draw_id}).first
    @draw_result = session.fetch("draw_result").to_i     #extract the draw_result from the params hash
    last_draw.draw_result = @draw_result
    last_draw.save 
  end    

  #create the next draw
    the_draw = Draw.new                               #create a new draw
    the_draw.roster_id = roster_sample.id                   #set field
    the_draw.name_match = roster_sample.preferred_name      #set field
    the_draw.play_id = session.fetch("play_id")
    the_draw.save
    
    play_id = session.fetch("play_id")                  #extract the current_play from the session hash
    the_draws = Draw.all.where({:play_id => play_id})   #return an array of draws for the most recent play
    draw_count = the_draws.count                        #count the draws in the current play
    the_draw.draw_count = draw_count                    #set the current record draw_count equal to the draws count of the current play
    the_draw.play_id = session.fetch("play_id")         #set draw play_id
    the_draw.save                                       #save the changes

    session.store(:draw_number, draw_count)
    session.store(:draw_id, the_draw.id)
    @draw_count = draw_count

    render({:template => "draws/new_draw.html.erb"})

  
end


  def draw_result
    @draw_solution = params.fetch("draw_solution")      #extract the draw solution from the params hash
    @response = params.fetch("answer")                  #extract the user_response from the params hash
    play_id = session.fetch("play_id")                  #extract the current_play from the session hash
    
    @draw_id = params.fetch("draw_id")                  #return the draw_id from the params hash
    current_draw = Draw.all.where({:id => @draw_id}).at(0)
    current_draw.name_attempt = @response
    current_draw.save

    draw_check = session.fetch("draw_number")
    session.store(:draw_check, draw_check)
      

    play_id = session.fetch("play_id")                  #extract the current_play from the session hash
    the_draws = Draw.all.where({:play_id => play_id})   #return an array of draws for the most recent play
    draw_count = the_draws.count                        
  
    the_draws.each do |each_draw|                       #loop each of the records
      each_draw.draw_total = draw_count                 #over_write the draw_total with the current_draw count
      each_draw.save                                    #save
    end 


    render({:template => "draws/draw_result.html.erb"})
  end


  def play_history  
   #check to see if the user is logged in
    if @current_user == nil
    redirect_to("/") 

    else # proceed with script    
  
      #this s a feature to prevent a user from seeing another user's plays
      @play = params.fetch("play")
      the_play = Play.all.where({:id => @play}).first
      @play_user = the_play.user_id.to_s
      @user = @current_user.id.to_s

      if @user == @play_user #if you are the authorized user, proceed

      @draw_set = Draw.all.where({:play_id => @play}).order(:id => :desc)

       
      render({:template => "draws/play_history.html.erb"}) 

      else    #else, redirect to valid user's pages
      redirect_to("/user_plays/"+user)  
      end
    
    end

  end

  
  
  def index
    matching_draws = Draw.all
    @list_of_draws = matching_draws.order({ :created_at => :desc })
    render({ :template => "draws/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_draws = Draw.where({ :id => the_id })
    @the_draw = matching_draws.at(0)
    render({ :template => "draws/show.html.erb" })
  end

  def create
    the_draw = Draw.new
    the_draw.roster_id = params.fetch("query_roster_id")
    the_draw.name_match = params.fetch("query_name_match")
    the_draw.name_attempt = params.fetch("query_name_attempt")
    the_draw.play_id = params.fetch("query_play_id")

    if the_draw.valid?
      the_draw.save
      redirect_to("/draws", { :notice => "Draw created successfully." })
    else
      redirect_to("/draws", { :notice => "Draw failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_draw = Draw.where({ :id => the_id }).at(0)
    the_draw.roster_id = params.fetch("query_roster_id")
    the_draw.name_match = params.fetch("query_name_match")
    the_draw.name_attempt = params.fetch("query_name_attempt")
    the_draw.play_id = params.fetch("query_play_id")

    if the_draw.valid?
      the_draw.save
      redirect_to("/draws/#{the_draw.id}", { :notice => "Draw updated successfully."} )
    else
      redirect_to("/draws/#{the_draw.id}", { :alert => "Draw failed to update successfully." })
    end

  end

  def destroy
    the_id = params.fetch("path_id")
    the_draw = Draw.where({ :id => the_id }).at(0)
    the_draw.destroy

    redirect_to("/draws", { :notice => "Draw deleted successfully."} )
  end

end

