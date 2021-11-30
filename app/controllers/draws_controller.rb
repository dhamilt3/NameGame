class DrawsController < ApplicationController
  
  def new_draw
    draw_id = Roster.all.sample   #sample the database
    @photo = draw_id.image        #extract a photo from the sample
    @draw_id = draw_id.id         #extract the draw_id from the sample
    @draw_record = Roster.all.where({:id => @draw_id}).at(0)
      if draw_id.draws_count == nil
        @number = 1
      else  
        @number= draw_id.draws_count.to_i + 1   #create a variable of "draws_count" + 1
      end
    draw_id.draws_count = @number      #update the draws count
    draw_id.save

    the_draw = Draw.new                               #create a new draw
    the_draw.roster_id = draw_id.id                   #set field
    the_draw.name_match = draw_id.preferred_name      #set field
    the_draw.play_id = session.fetch("play_id")       #set field
    the_draw.save                                     #save the record

    render({:template => "draws/new_draw.html.erb"})
  end
  
  def draw_result
    draw_solution = params.fetch("draw_solution")
    @draw_solution = Roster.all.where({:id => draw_solution}).at(0)
    @answer = params.fetch("answer")
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
