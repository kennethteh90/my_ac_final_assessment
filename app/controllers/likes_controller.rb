class LikesController < ApplicationController

  def create
    @note = Note.find(params[:format])
    if current_user.like(@note)
      flash[:notice] = "You have liked the note!"
      redirect_to notes_path
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if current_user.unlike(@note)
      flash[:notice] = "You have unliked the note!"
      redirect_to notes_path
    end
  end

end