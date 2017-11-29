class NotesController < ApplicationController

before_action :authenticate_user!, only: [:create, :destroy, :edit, :update]

  def index
    if user_signed_in?
      @users = current_user.followees
      @notes = Note.where(id: @users).reverse
    else
      @users = User.all
      @notes = Note.all.reverse
    end
    @note = Note.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      flash[:notice] = "Note saved!"
      redirect_to notes_path
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:alert] = "Note deleted!"
    redirect_to notes_path
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      flash[:notice] = "Note updated!"
      redirect_to notes_path
    else
      flash.now[:alert] = "Oops, note did not update!"
      render :edit
    end
  end

  private

    def note_params
      params.require(:note).permit(:title, :body)
    end

end
