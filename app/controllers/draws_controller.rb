class DrawsController < ApplicationController
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
