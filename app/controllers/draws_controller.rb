class DrawsController < ApplicationController
  
  def new_draw
    roster_sample = Roster.all.sample   #sample the database
    @photo = roster_sample.image        #extract a photo from the sample
    @roster_id = roster_sample.id         #extract the roster_id from the sample
    @roster_record = Roster.all.where({:id => @roster_id}).at(0)
      if roster_sample.draws_count == nil
        @number = 1
      else  
        @number= roster_sample.draws_count.to_i + 1   #create a variable of "draws_count" + 1
      end
    roster_sample.draws_count = @number      #update the draws count
    roster_sample.save



    the_draw = Draw.new                               #create a new draw
    the_draw.roster_id = roster_sample.id                   #set field
    the_draw.name_match = roster_sample.preferred_name      #set field
    the_draw.play_id = session.fetch("play_id")       #set field
    the_draw.draw_count = the_draw.draw_count.to_i + 1   #populate the draw_count
    the_draw.save                                     #save the record
    @draw = Draw.all.where({:id => the_draw.id}).at(0)    #create an instance variable for the draw_id

   @draw_num = session.fetch("draw_number")
    if @draw_num == nil
       session.store(:draw_number, 1)
       @draw_num = 1
    else
      @draw_num = @draw_num.to_i + 1
      session.store(:draw_number, @draw_num)
    end


    render({:template => "draws/new_draw.html.erb"})
  end
  
  def draw_result
    @draw_solution = params.fetch("draw_solution")
    @response = params.fetch("answer")

    play_id = session.fetch("play_id")
    the_draws = Draw.all.where({:play_id => play_id})


    draw_id = params.fetch("draw_id")

    the_draws.each do |each_draw| 
      each_draw.draw_count = each_draw.draw_count.to_i + 1
      each_draw.draw_total
      each_draw.save
    end

    play_id = session.fetch("play_id")                  #fetch cookie for the current play
    the_draws = Draw.all.where({:play_id => play_id})   #find matching play records
    max_record = the_draws.min                           #return the newest record
    max = max_record.draw_count                         #create a variable for the draw_count on the max_record 

    the_draws.each do |each_draw|                       #loop each of the records
      each_draw.draw_total = max                        #over write each record to the largest value
      each_draw.save                                    #save
    end
     

    render({:template => "draws/draw_result.html.erb"})
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
