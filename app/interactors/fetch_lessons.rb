# frozen_string_literal: true

class FetchLessons < ApplicationInteractor
  expects do
    required(:classroom).filled
    required(:page_params).filled
    required(:filters).value(:hash?)
  end

  assures do
    required(:lessons).filled
  end

  def call
    context.lessons =
      Lesson.
      where(classroom: context.classroom).
      where(context.filters).
      page(context.page_params[:number]).
      per(context.page_params[:size]).
      order(created_at: :desc)
  end
end
