class RostersController < ApplicationController
  def index
    if session.fetch(:play_ongoing) == 1    #check to see if a new_draw is in process and unresolved, if so this new_draw will do nothing, otherwise, it will run the entire new_draw controller
      session.store(:play_ongoing, nil)     #delete the session cookie
      redirect_to("/roster", { :alert => "Play abandoned."}) 

    #destroy the abandoned play
    the_id = session.fetch("play_id")
    the_play = Play.where({ :id => the_id }).at(0)
    play_id = the_play.id
    the_play.destroy

    #destory the abandoned draws
    the_draws = Draw.all.where({:play_id => play_id})
    the_draws.each do |draw|
    draw.destroy
    end

    #destroy the session cookies
    session.store(:play_ongoing, nil) 
    session.store(:draw_ongoing, nil)    
    session.store(:play_id, nil)
    session.store(:draw_id, nil)
    session.store(:draw_number, nil)
      
    else #run the entire play script uninterrupted

    matching_rosters = Roster.all
    @list_of_rosters = matching_rosters.order({ :created_at => :desc })
    render({ :template => "roster/index.html.erb" })

    end
  end

  def show
    the_id = params.fetch("path_id")
    matching_rosters = Roster.where({ :id => the_id })
    @the_roster = matching_rosters.at(0)
    render({ :template => "roster/show.html.erb" })
  end

  def create
    the_roster = Roster.new
    the_roster.badge_number = params.fetch("query_badge_number")
    the_roster.first_name = params.fetch("query_first_name")
    the_roster.last_name = params.fetch("query_last_name")
    the_roster.preferred_name = params.fetch("query_preferred_name")
    the_roster.shift = params.fetch("query_shift")
    the_roster.department = params.fetch("query_department")
    the_roster.role = params.fetch("query_role")
    the_roster.image = params.fetch("query_image")

    if the_roster.valid?
      the_roster.save
      redirect_to("/roster", { :notice => "Roster created successfully." })
    else
      redirect_to("/roster", { :notice => "Roster failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_roster = Roster.where({ :id => the_id }).at(0)
    the_roster.badge_number = params.fetch("query_badge_number")
    the_roster.first_name = params.fetch("query_first_name")
    the_roster.last_name = params.fetch("query_last_name")
    the_roster.preferred_name = params.fetch("query_preferred_name")
    the_roster.shift = params.fetch("query_shift")
    the_roster.department = params.fetch("query_department")
    the_roster.role = params.fetch("query_role")
    the_roster.image = params.fetch("query_image")
    the_roster.draws_count = params.fetch("query_draws_count")

    if the_roster.valid?
      the_roster.save
      redirect_to("/roster/#{the_roster.id}", { :notice => "Roster updated successfully."} )
    else
      redirect_to("/roster/#{the_roster.id}", { :alert => "Roster failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_roster = Roster.where({ :id => the_id }).at(0)

    the_roster.destroy

    redirect_to("/roster", { :notice => "Roster deleted successfully."} )
  end
end
