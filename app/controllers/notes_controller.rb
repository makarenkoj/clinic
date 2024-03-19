class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = current_user.notes.order(date_time: params_order).paginate(page: params[:page])
  end

  def show
    @note = Note.find_by(id: params[:id])
  end

  def edit
    @note = Note.find(params[:id])
    redirect_to new_note_path, notice: t('controllers.note.edit') unless @note.user == current_user
  end

  def new
    @note = current_user.notes.build
  end

  def create
    note = current_user.notes.build(note_params)

    if note.save
      redirect_to note, notice: t('controllers.appointments.created')
    else
      redirect_to new_note_url, notice: errors_message_html(note.errors)
    end
  end

  def update
    note = Note.find(params[:id])
    render :edit, notice: t('controllers.note.edit') unless note.user == current_user

    if note.update(note_params)
      redirect_to note, notice: t('controllers.note.updated')
    else
      render :edit
    end
  end

  def destroy
    note = current_user.notes.find(params[:id])

    if note.destroy
      redirect_to root_path, notice: t('controllers.users.destroyed')
    else
      redirect_to root_path, notice: t('controllers.note.edit')
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :date_time)
  end
end
