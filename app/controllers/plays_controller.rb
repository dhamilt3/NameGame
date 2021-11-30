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
    the_play = Play.new
    the_play.user_id = @current_user.id
    the_play.save
    @current_play = the_play.id
    session.store(:play_id, @current_play)
    render({:template => "plays/new_play.html.erb"})
  end

  def home
    render({:template => "plays/start.html.erb"})
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

  def update
    the_id = params.fetch("path_id")
    the_play = Play.where({ :id => the_id }).at(0)

    the_play.user_id = params.fetch("query_user_id")
    the_play.correct_sum = params.fetch("query_correct_sum")
    the_play.incorrect_sum = params.fetch("query_incorrect_sum")
    the_play.result = params.fetch("query_result")
    the_play.draws_count = params.fetch("query_draws_count")

    if the_play.valid?
      the_play.save
      redirect_to("/plays/#{the_play.id}", { :notice => "Play updated successfully."} )
    else
      redirect_to("/plays/#{the_play.id}", { :alert => "Play failed to update successfully." })
    end
  end

  # def destroy
  #   the_id = params.fetch("path_id")
  #   the_play = Play.where({ :id => the_id }).at(0)
  #   the_play.destroy
  #   redirect_to("/plays", { :notice => "Play deleted successfully."} )
  # end
end
