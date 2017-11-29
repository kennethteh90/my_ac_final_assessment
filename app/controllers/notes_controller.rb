class NotesController < ApplicationController

  def index
    @notes = Note.all
    @users = User.all
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      flash[:notice] = "Note saved!"
      redirect_to notes_path
    end
  end

  def destroy
    Note.destroy(params[:id])
    flash[:alert] = "Note deleted!"
    redirect_to notes_path
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    # @note.update(note_params)
    if @note.update(note_params)
      flash[:notice] = "Note updated!"
      redirect_to notes_path
    end
  end

  private

    def note_params
      params.require(:note).permit(:title, :body)
    end

end
