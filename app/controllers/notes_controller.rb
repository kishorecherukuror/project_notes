class NotesController < ApplicationController
 
  before_action :set_note, only: [:edit,:update,:rollback]

  def index
    @notes = Note.all
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to notes_url, notice: 'Note was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to notes_url, notice: 'Note was successfully updated.'
    else
      render :edit
    end
  end

  def rollback
    @old_note = @note.versions.last
    @note = @old_note.reify
    @note.paper_trail.without_versioning do
      @note.save
    end
    @note.versions.last.destroy
    redirect_to notes_url, notice: 'Note rolled back to old version'
  end

  private

  def set_note
    @note = Note.find(params[:id]) 
  end  
  def note_params
    params.require(:note).permit(:title, :description)
  end

end
