class NotesController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_owner, only: [:destroy]

  def create
    note = Note.new(note_params)
    note.track_id = params[:track_id]
    note.user_id = current_user.id

    note.save
    flash[:errors] = note.try(:errors).try(:full_messages)
    redirect_to track_url(note.track_id)
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    redirect_to track_url(note.track_id)
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end

  def ensure_owner
    note = Note.find(params[:id])
    redirect_to track_url(note.track_id) if current_user.id != note.user_id
  end
end